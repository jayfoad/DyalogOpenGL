#!/usr/bin/python
# coding=utf-8

# Generate APL bindings for OpenGL

from __future__ import print_function # to ease the transition to Python 3

import re
import urllib2

print(':Namespace GL')
print()

print('⍝ Dependencies')
print('⍝∇:require =/DyalogXX')
print()

# Read the OpenGL enumerants and emit them as APL
e = False
for line in urllib2.urlopen('http://www.opengl.org/registry/api/enum.spec'):
    if '#' in line:
        line = line[:line.index('#')]
    if ' define:' in line:
        e = False
    elif ' enum:' in line:
        e = True
    elif e:
        t = [x.strip() for x in line.split('=')]
        if len(t) == 2:
            v = t[1]
            if not v.startswith('GL_'):
                v = str(int(v.rstrip('ul'), 0))
            print('GL_' + t[0] + '←' + v)
print()

# Insert some helper functions

print('∇ r←getdllname')
print('  :If \'Windows\'≡7↑⊃#.⎕WG\'APLVersion\'')
print('      r←\'opengl32\'')
print('  :Else')
print('      r←\'libGL.so\'')
print('  :Endif')
print('∇')
print()
print('∇ r←ptostring p;l')
print('  :If p=0')
print('      r←\'\'')
print('  :Else')
print('      :If 0=⎕NC\'strlen\'')
print('          \'strlen\'⎕NA\'P \',#.DyalogXX.GetDLLName,\'|STRLEN P\'')
print('      :EndIf')
print('      l←strlen p')
print('      :If 0=⎕NC\'memcpy\'')
print('          \'memcpy\'⎕NA\'P \',#.DyalogXX.GetDLLName,\'|MEMCPY >U1[] P P\'')
print('      :EndIf')
print('      p r←memcpy l p l')
# OpenGL 3.1 onwards specifies that the strings returned by glGetString are
# UTF-8 encoded.
print('      r←\'UTF-8\' ⎕UCS r')
print('  :EndIf')
print('∇')
print()

checkerrors = False
if checkerrors:
    print('∇ checkerror;e')
    print('  :If 0≠e←glGetError')
    print('      (\'OpenGL error \',⍕e) ⎕SIGNAL 11')
    print('  :EndIf')
    print('∇')
    print()

# Read the OpenGL typemap
tm = {}
for line in urllib2.urlopen('http://www.opengl.org/registry/api/gl.tm'):
    if '#' in line:
        line = line[:line.index('#')]
    fields = line.split(',')
    if len(fields) >= 6:
        tm[fields[0].strip()] = fields[3].strip()

# Create a C-to-APL typemap
am = {
    # from gl.h
    "GLenum" : "U4",
    "GLboolean" : "U1",
    "GLbitfield" : "U4",
    "GLbyte" : "I1",
    "GLshort" : "I2",
    "GLint" : "I4",
    "GLubyte" : "U1",
    "GLushort" : "U2",
    "GLuint" : "U4",
    "GLsizei" : "I4",
    "GLfloat" : "F4",
    "GLclampf" : "F4",
    "GLdouble" : "F8",
    "GLclampd" : "F8",

    # from gl.spec
    # "GLchar" : "I1",
    # "GLintptr" : "P",
    # "GLsizeiptr" : "P",
    # "GLintptrARB" : "P",
    # "GLsizeiptrARB" : "P",
    # "GLcharARB" : "I1",
    "GLhandleARB" : "U4",
    # "GLhalfARB" : "U2",
    # "GLhalfNV" : "U2",
    "GLint64EXT" : "I8",
    "GLuint64EXT" : "U8",
    "GLint64" : "I8",
    "GLuint64" : "U8",
    # "GLsync" : "P",

    # "GLvdpauSurfaceNV" : "?",
}

# See Table 3.2 in the OpenGL 4.2 spec
pixeltypes = [
    ['GL_UNSIGNED_BYTE', 'GLubyte'],
    ['GL_BYTE', 'GLbyte'],
    ['GL_UNSIGNED_SHORT', 'GLushort'],
    ['GL_SHORT', 'GLshort'],
    ['GL_UNSIGNED_INT', 'GLuint'],
    ['GL_INT', 'GLint'],
    # ['GL_HALF_FLOAT', 'GLhalf'],
    ['GL_FLOAT', 'GLfloat'],
    ['GL_UNSIGNED_BYTE_3_3_2', 'GLubyte'],
    ['GL_UNSIGNED_BYTE_2_3_3_REV', 'GLubyte'],
    ['GL_UNSIGNED_SHORT_5_6_5', 'GLushort'],
    ['GL_UNSIGNED_SHORT_5_6_5_REV', 'GLushort'],
    ['GL_UNSIGNED_SHORT_4_4_4_4', 'GLushort'],
    ['GL_UNSIGNED_SHORT_4_4_4_4_REV', 'GLushort'],
    ['GL_UNSIGNED_SHORT_5_5_5_1', 'GLushort'],
    ['GL_UNSIGNED_SHORT_1_5_5_5_REV', 'GLushort'],
    ['GL_UNSIGNED_INT_8_8_8_8', 'GLuint'],
    ['GL_UNSIGNED_INT_8_8_8_8_REV', 'GLuint'],
    ['GL_UNSIGNED_INT_10_10_10_2', 'GLuint'],
    ['GL_UNSIGNED_INT_2_10_10_10_REV', 'GLuint'],
    ['GL_UNSIGNED_INT_24_8', 'GLuint'],
    ['GL_UNSIGNED_INT_10F_11F_11F_REV', 'GLuint'],
    ['GL_UNSIGNED_INT_5_9_9_9_REV', 'GLuint'],
]

def formatrettype(t):
    if t == 'void':
        return ''
    if t == 'String':
        return 'P '
    t = tm[t]
    # if t.endswith('*'):
    #     return 'P '
    return am[t] + ' '

def formatargtype(t):
    return am[tm[t]]

def printfunc(rettype, funcname, params, cfuncname = None):
    if cfuncname is None:
        cfuncname = funcname

    numretvals = 0
    if rettype != 'void':
        numretvals = numretvals + 1

    try:
        retstr = formatrettype(rettype)
    except KeyError:
        retstr = None

    argnames = []
    argvals = []
    argstr = ''
    for t in params:
        if t[3] == 'in':
            argnames = argnames + [t[1]]
            argvals = argvals + [t[1]]
            if argstr is not None:
                try:
                    if t[4] == 'value':
                        argstr = argstr + ' ' + formatargtype(t[2])
                    elif t[4] == 'array':
                        argstr = argstr + ' <' + formatargtype(t[2])
                        if re.match('\[[0-9]+\]', t[5]):
                            argstr = argstr + t[5]
                        else:
                            argstr = argstr + '[]'
                    else:
                        argstr = None
                except KeyError:
                    argstr = None
        elif t[3] == 'out' and t[4] == 'array':
            numretvals = numretvals + 1
            if re.match('\[[0-9]+\]', t[5]):
                argvals = argvals + [t[5].strip('[]')]
            else:
                argnames = argnames + [t[1]]
                argvals = argvals + [t[1]]
            if argstr is not None:
                try:
                    argstr = argstr + ' >' + formatargtype(t[2])
                    if re.match('\[[0-9]+\]', t[5]):
                        argstr = argstr + t[5]
                    else:
                        argstr = argstr + '[]'
                except KeyError:
                    argstr = None
        else:
            argstr = None

    # Spot functions like TexImage2D
    pixeltypeargs = [i for i in range(len(params)) if params[i][2:] == ['PixelType', 'in', 'value']]
    pixeldataargs = [i for i in range(len(params)) if params[i][2:5] == ['Void', 'in', 'array']]
    if len(pixeltypeargs) == 1 and len(pixeldataargs) == 1:
        pta = pixeltypeargs[0]
        pda = pixeldataargs[0]
        if funcname.startswith('gl'):
            fn = funcname[2:]
        else:
            fn = funcname
        for t in ['UInt8', 'Int8', 'UInt16', 'Int16', 'UInt32', 'Int32', 'Float32']:
            params[pda][2] = t
            printfunc(rettype, fn + '_' + am[tm[t]], params, cfuncname)
    else:
        pta = None
        pda = None

    # Header
    print('∇ ', end = '')
    if numretvals != 0:
        print('r←', end = '')
    print(funcname, end = '')
    if len(argnames) == 0:
        print()
    elif len(argnames) == 1:
        print(' ' + argnames[0])
    else:
        print(' (' + ' '.join(argnames) + ')')

    # Body
    if pta is not None and pda is not None:
        print('  :Select ' + params[pta][1])
        for pt in pixeltypes:
            print('  :Case ' + pt[0])
            print('      ', end = '')
            if numretvals != 0:
                print('r←', end = '')
            print(fn + '_' + am[pt[1]] + ''.join([' ' + a for a in argvals]))
        print('  :Else')
        print('      ⎕SIGNAL 11')
        print('  :EndSelect')
    else:
        print('  :If 0=⎕NC\'' + funcname + '_DLL\'')
        print('      \'' + funcname + '_DLL\'⎕NA', end = '')
        if retstr is None or argstr is None:
            print(' ⎕SIGNAL 16')
        else:
            print('\'' + retstr + '\',getdllname,\'|' + cfuncname + argstr + '\'')
        print('  :EndIf')
        if numretvals == 0:
            print('  {}', end = '')
        else:
            print('  r←', end = '')
        if rettype == 'String':
            print('ptostring ', end = '')
        print(funcname + '_DLL' + ''.join([' ' + a for a in argvals]))
        if checkerrors and cfuncname != 'glGetError':
            print('  checkerror')

    # Trailer
    print('∇')
    print()

# Read the OpenGL functions and emit APL stubs for them
funcname = None
for line in urllib2.urlopen('http://www.opengl.org/registry/api/gl.spec'):
    if '#' in line:
        line = line[:line.index('#')]
    m = re.match('(\w+)\((.*)\)', line)
    if m:
        funcname = 'gl' + m.group(1)
        rettype = None
        params = []
    elif funcname:
        t = line.split()
        if len(t) == 0:
            printfunc(rettype, funcname, params)
            funcname = None
        elif t[0] == 'return':
            rettype = t[1]
        elif t[0] == 'param':
            params = params + [t]

print(':EndNamespace')
