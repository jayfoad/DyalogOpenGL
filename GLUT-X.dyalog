:Namespace GLUT

⍝ APL implementations of a few GLUT
⍝ (http://www.opengl.org/resources/libraries/glut/) functions.

⍝ (I decided to implement this in APL, rather than call out to a native GLUT
⍝ DLL, because Windows doesn't seem to ship with GLUT. --JMF)

⍝ Some of this code is closely based on the C source code for GLUT, which
⍝ carries the following notices:

⍝ (c) Copyright 1993, Silicon Graphics, Inc.
⍝
⍝ ALL RIGHTS RESERVED
⍝
⍝ Permission to use, copy, modify, and distribute this software
⍝ for any purpose and without fee is hereby granted, provided
⍝ that the above copyright notice appear in all copies and that
⍝ both the copyright notice and this permission notice appear in
⍝ supporting documentation, and that the name of Silicon
⍝ Graphics, Inc. not be used in advertising or publicity
⍝ pertaining to distribution of the software without specific,
⍝ written prior permission.

⍝ Dependencies
⍝∇:require =/GL
⍝∇:require =/GLU
⍝∇:require =/Xlib
⍝∇:require =/GLX

⎕ML←3 ⍝ because static data (e.g. cpdata) initialisation uses "⊃" for "mix"

GLUT_RGB←0
GLUT_RGBA←GLUT_RGB
GLUT_SINGLE←0
GLUT_INDEX←1
GLUT_DOUBLE←2
GLUT_ACCUM←4
GLUT_ALPHA←8
GLUT_DEPTH←16
GLUT_STENCIL←32
GLUT_MULTISAMPLE←128
GLUT_STEREO←256
GLUT_LUMINANCE←512

initialwindowposition←0 0
initialwindowsize←300 300

∇ glutInit
  ⎕EX 'displayfunc' 'reshapefunc' 'keyboardfunc'
  redisplay←0
  dpy←#.Xlib.XOpenDisplay
∇

∇ glutInitWindowPosition pos
  :If ∧/pos≥0
      initialwindowposition←pos
  :Endif
∇

∇ glutInitWindowSize sz
  :If ∧/sz>0
      initialwindowsize←sz
  :Endif
∇

∇ glutInitDisplayMode mode
  displaymode←mode
∇

∇ glutMainLoop;⎕IO;e
  ⎕IO←0
  :While 1
      :If redisplay
          :If 0≠⎕NC'displayfunc'
              ⍎displayfunc
          :Endif
          redisplay←0
      :Endif

      e←#.Xlib.XNextEvent dpy
      :Select ⍬⍴e
      :Case #.Xlib.KeyPress
          :If 0≠⎕NC'keyboardfunc'
              (⍎keyboardfunc) e[13 8 9]
          :Endif
      :Case #.Xlib.Expose
          :If e[9]=0
              :If 0≠⎕NC'displayfunc'
                  ⍎displayfunc
              :Endif
          :Endif
      :Case #.Xlib.ConfigureNotify
          :If 0≠⎕NC'reshapefunc'
              (⍎reshapefunc) e[8 9]
          :Endif
      :Case #.Xlib.ClientMessage
          :If e[⊂7 0]=wmdeletemessage
              :Leave
          :Endif
      :EndSelect
  :EndWhile
  #.Xlib.XCloseDisplay dpy ⋄ ⎕EX'dpy'
∇

PFD_DOUBLEBUFFER←1
PFD_STEREO←2
PFD_DRAW_TO_WINDOW←4
PFD_SUPPORT_OPENGL←32

∇ {w}←glutCreateWindow title;s;r;bitand;a;fs;f;v;cw;em;cmap;ctx
  s←#.Xlib.XDefaultScreen dpy
  r←#.Xlib.XDefaultRootWindow dpy

  bitand←{∨/∧/2(⊥⍣¯1)⍺ ⍵}

  a←#.GLX.GLX_X_RENDERABLE #.Xlib.True #.Xlib.None
  :If displaymode bitand GLUT_DOUBLE
      a←#.GLX.GLX_DOUBLEBUFFER #.Xlib.True,a
  :Endif
  :If displaymode bitand GLUT_STEREO
      a←#.GLX.GLX_STEREO #.Xlib.True,a
  :Endif

  fs←#.GLX.glXChooseFBConfig dpy s a
  :If 0=⍴fs
      ⎕SIGNAL 999 ⍝ ???
  :EndIf
  f←⍬⍴fs
  v←#.GLX.glXGetVisualFromFBConfig dpy f
  cw←#.Xlib.CWEventMask+#.Xlib.CWColormap
  em←#.Xlib.KeyPressMask+#.Xlib.ExposureMask+#.Xlib.StructureNotifyMask
  cmap←#.Xlib.XCreateColormap dpy r v.visual #.Xlib.AllocNone
  w←#.Xlib.XCreateWindow dpy r,initialwindowposition,initialwindowsize,0 v.depth #.Xlib.InputOutput v.visual cw (0 0 0 0 0 0 0 0 0 0 em 0 0 cmap 0)
  #.Xlib.XStoreName dpy w title
  wmdeletemessage←#.Xlib.XInternAtom dpy 'WM_DELETE_WINDOW' #.Xlib.False
  #.Xlib.XSetWMProtocols dpy w wmdeletemessage
  #.Xlib.XMapWindow dpy w
  ctx←#.GLX.glXCreateNewContext dpy f #.GLX.GLX_RGBA_TYPE 0 #.Xlib.True
  :If ctx=0
      ⎕SIGNAL 999 ⍝ ???
  :Endif
  #.GLX.glXMakeCurrent dpy w ctx
  currentwindow←w
∇

∇ glutSetWindow w
  currentwindow←w
∇

∇ w←glutGetWindow
  w←currentwindow
∇

∇ glutPostRedisplay
  redisplay←1
∇

∇ glutDisplayFunc func
  displayfunc←func
∇

∇ glutSwapBuffers
  #.GLX.glXSwapBuffers dpy currentwindow
∇

∇ glutReshapeFunc func
  reshapefunc←func
∇

∇ glutKeyboardFunc func
  keyboardfunc←func
∇

∇ glutIdleFunc func
  FIXME
∇

∇ r←glutExtensionSupported extension;⎕ML;t
  ⎕ML←3
  :If 0=⎕NC'extensions'
      t←#.GL.glGetString #.GL.GL_EXTENSIONS
      extensions←(t≠' ')⊂t
  :Endif
  r←(⊂extension)∊extensions
∇

⍝ Shapes ⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

∇ r←sqrt r
  r←r*0.5
∇

∇ glutWireSphere (radius slices stacks);quadObj
  quadObj←#.GLU.gluNewQuadric
  #.GLU.gluQuadricDrawStyle quadObj #.GLU.GLU_LINE
  #.GLU.gluQuadricNormals quadObj #.GLU.GLU_SMOOTH
  #.GLU.gluSphere quadObj radius slices stacks
∇

∇ glutSolidSphere (radius slices stacks);quadObj
  quadObj←#.GLU.gluNewQuadric
  #.GLU.gluQuadricDrawStyle quadObj #.GLU.GLU_FILL
  #.GLU.gluQuadricNormals quadObj #.GLU.GLU_SMOOTH
  #.GLU.gluSphere quadObj radius slices stacks
∇

∇ glutWireCone (base height slices stacks);quadObj
  obj←#.GLU.gluNewQuadric
  #.GLU.gluQuadricDrawStyle quadObj #.GLU.GLU_LINE
  #.GLU.gluQuadricNormals quadObj #.GLU.GLU_SMOOTH
  #.GLU.gluCylinder quadObj base 0 height slices stacks
∇

∇ glutSolidCone (base height slices stacks);quadObj
  obj←#.GLU.gluNewQuadric
  #.GLU.gluQuadricDrawStyle quadObj #.GLU.GLU_FILL
  #.GLU.gluQuadricNormals quadObj #.GLU.GLU_SMOOTH
  #.GLU.gluCylinder quadObj base 0 height slices stacks
∇

∇ drawBox (size type);⎕IO;n;faces;v;i
  ⎕IO←0

  n←6 3⍴¯1 0 0 0 1 0 1 0 0 0 ¯1 0 0 0 1 0 0 ¯1
  faces←6 4⍴0 1 2 3 3 2 6 7 7 6 5 4 4 5 1 0 5 6 2 1 7 4 0 3
  v←8 3⍴0

  v[0 1 2 3;0]←-size÷2
  v[4 5 6 7;0]←size÷2
  v[0 1 4 5;1]←-size÷2
  v[2 3 6 7;1]←size÷2
  v[0 3 4 7;2]←-size÷2
  v[1 2 5 6;2]←size÷2

  :For i :In ⌽⍳6
      #.GL.glBegin type
      #.GL.glNormal n[i;]
      #.GL.glVertex(v[faces[i;0];])
      #.GL.glVertex(v[faces[i;1];])
      #.GL.glVertex(v[faces[i;2];])
      #.GL.glVertex(v[faces[i;3];])
      #.GL.glEnd
  :EndFor
∇

∇ glutWireCube size
  drawBox size #.GL.GL_LINE_LOOP
∇

∇ glutSolidCube size
  drawBox size #.GL.GL_QUADS
∇

∇ doughnut (r R nsides rings);ringDelta;sideDelta;theta;cosTheta;sinTheta;i;theta1;cosTheta1;sinTheta1;phi;j;cosPhi;sinPhi;dist;⎕IO
  ⎕IO←0

  ringDelta←2×○÷rings
  sideDelta←2×○÷nsides

  theta←0
  cosTheta←1
  sinTheta←0
  :For i :In ⌽⍳rings
      theta1←theta+ringDelta
      cosTheta1←2○theta1
      sinTheta1←1○theta1
      #.GL.glBegin #.GL.GL_QUAD_STRIP
      phi←0
      :For j :In ⌽⍳nsides+1
          phi+←sideDelta
          cosPhi←2○phi
          sinPhi←1○phi
          dist←R+r×cosPhi

          #.GL.glNormal (cosTheta1×cosPhi) (-sinTheta1×cosPhi) sinPhi
          #.GL.glVertex (cosTheta1×dist) (-sinTheta1×dist) (r×sinPhi)
          #.GL.glNormal (cosTheta×cosPhi) (-sinTheta×cosPhi) sinPhi
          #.GL.glVertex (cosTheta×dist) (-sinTheta×dist) (r×sinPhi)
      :EndFor
      #.GL.glEnd
      theta←theta1
      cosTheta←cosTheta1
      sinTheta←sinTheta1
  :EndFor
∇

∇ glutWireTorus (innerRadius outerRadius nsides rings)
  #.GL.glPushAttrib #.GL.GL_POLYGON_BIT
  #.GL.glPolygonMode #.GL.GL_FRONT_AND_BACK #.GL.GL_LINE
  doughnut innerRadius outerRadius nsides rings
  #.GL.glPopAttrib
∇

∇ glutSolidTorus (innerRadius outerRadius nsides rings)
  doughnut innerRadius outerRadius nsides rings
∇

∇ initDodecahedron;⎕IO;alpha;beta
  ⎕IO←0

  dodec←20 3⍴0

  alpha←sqrt 2÷(3+sqrt 5)
  beta←1+(sqrt(6÷(3+sqrt 5)))-2-2×sqrt 2÷(3+sqrt 5)

  dodec[0;0]←-alpha ⋄ dodec[0;1]←0 ⋄ dodec[0;2]←beta
  dodec[1;0]←alpha ⋄ dodec[1;1]←0 ⋄ dodec[1;2]←beta
  dodec[2;0]←-1 ⋄ dodec[2;1]←-1 ⋄ dodec[2;2]←-1
  dodec[3;0]←-1 ⋄ dodec[3;1]←-1 ⋄ dodec[3;2]←1
  dodec[4;0]←-1 ⋄ dodec[4;1]←1 ⋄ dodec[4;2]←-1
  dodec[5;0]←-1 ⋄ dodec[5;1]←1 ⋄ dodec[5;2]←1
  dodec[6;0]←1 ⋄ dodec[6;1]←-1 ⋄ dodec[6;2]←-1
  dodec[7;0]←1 ⋄ dodec[7;1]←-1 ⋄ dodec[7;2]←1
  dodec[8;0]←1 ⋄ dodec[8;1]←1 ⋄ dodec[8;2]←-1
  dodec[9;0]←1 ⋄ dodec[9;1]←1 ⋄ dodec[9;2]←1
  dodec[10;0]←beta ⋄ dodec[10;1]←alpha ⋄ dodec[10;2]←0
  dodec[11;0]←beta ⋄ dodec[11;1]←-alpha ⋄ dodec[11;2]←0
  dodec[12;0]←-beta ⋄ dodec[12;1]←alpha ⋄ dodec[12;2]←0
  dodec[13;0]←-beta ⋄ dodec[13;1]←-alpha ⋄ dodec[13;2]←0
  dodec[14;0]←-alpha ⋄ dodec[14;1]←0 ⋄ dodec[14;2]←-beta
  dodec[15;0]←alpha ⋄ dodec[15;1]←0 ⋄ dodec[15;2]←-beta
  dodec[16;0]←0 ⋄ dodec[16;1]←beta ⋄ dodec[16;2]←alpha
  dodec[17;0]←0 ⋄ dodec[17;1]←beta ⋄ dodec[17;2]←-alpha
  dodec[18;0]←0 ⋄ dodec[18;1]←-beta ⋄ dodec[18;2]←alpha
  dodec[19;0]←0 ⋄ dodec[19;1]←-beta ⋄ dodec[19;2]←-alpha
∇

∇ prod←crossprod (v1 v2);⎕IO
  ⎕IO←0

  prod←3⍴0
  prod[0]←(v1[1]×v2[2])-v2[1]×v1[2]
  prod[1]←(v1[2]×v2[0])-v2[2]×v1[0]
  prod[2]←(v1[0]×v2[1])-v2[0]×v1[1]
∇

∇ v←normalize v;⎕IO;d
  ⎕IO←0

  d←sqrt +/v×v
  :If d=0
      v[0]←1
  :Else
      v×←÷d
  :EndIf
∇

∇ pentagon (a b c d e shadeType);⎕IO;d1;d2;n0
  ⎕IO←0

  d1←dodec[a;]-dodec[b;]
  d2←dodec[b;]-dodec[c;]
  n0←crossprod d1 d2
  n0←normalize n0

  #.GL.glBegin shadeType
  #.GL.glNormal n0
  #.GL.glVertex dodec[a;]
  #.GL.glVertex dodec[b;]
  #.GL.glVertex dodec[c;]
  #.GL.glVertex dodec[d;]
  #.GL.glVertex dodec[e;]
  #.GL.glEnd
∇

∇ dodecahedron type
  :If 0=⎕NC'dodec'
      initDodecahedron
  :EndIf
  pentagon 0 1 9 16 5 type
  pentagon 1 0 3 18 7 type
  pentagon 1 7 11 10 9 type
  pentagon 11 7 18 19 6 type
  pentagon 8 17 16 9 10 type
  pentagon 2 14 15 6 19 type
  pentagon 2 13 12 4 14 type
  pentagon 2 19 18 3 13 type
  pentagon 3 0 5 12 13 type
  pentagon 6 15 8 10 11 type
  pentagon 4 17 8 15 14 type
  pentagon 4 12 5 16 17 type
∇

∇ glutWireDodecahedron
  dodecahedron #.GL.GL_LINE_LOOP
∇

∇ glutSolidDodecahedron
  dodecahedron #.GL.GL_TRIANGLE_FAN
∇

∇ recorditem (n1 n2 n3 shadeType);q0;q1
  q0←n1-n2
  q1←n2-n3
  q1←crossprod q0 q1
  q1←normalize q1

  #.GL.glBegin shadeType
  #.GL.glNormal q1
  #.GL.glVertex n1
  #.GL.glVertex n2
  #.GL.glVertex n3
  #.GL.glEnd
∇

∇ subdivide (v0 v1 v2 shadeType);⎕IO;w0;w1;w2;depth;i;j;k;n
  ⎕IO←0

  w0←w1←w2←3⍴0

  depth←1
  :For i :In ⍳depth
      :For j :In ⍳depth-i
          k←depth-i+j
          :For n :In ⍳3
              w0[n]←((i j k)+.×n⊃¨v0 v1 v2)÷depth
              w1[n]←((i+1)j(k-1)+.×n⊃¨v0 v1 v2)÷depth
              w2[n]←(i(j+1)(k-1)+.×n⊃¨v0 v1 v2)÷depth
          :EndFor
          w1 w0 w2←normalize¨w1 w0 w2
          recorditem w1 w0 w2 shadeType
      :EndFor
  :EndFor
∇

∇ drawtriangle (i data ndx shadeType);⎕IO;x0;x1;x2
  ⎕IO←0

  x0←data[ndx[i;0];]
  x1←data[ndx[i;1];]
  x2←data[ndx[i;2];]
  subdivide x0 x1 x2 shadeType
∇

odata←6 3⍴1 0 0 ¯1 0 0 0 1 0 0 ¯1 0 0 0 1 0 0 ¯1

ondex←8 3⍴0 4 2 1 2 4 0 3 4 1 4 3 0 2 5 1 5 2 0 5 3 1 3 5

∇ octahedron shadeType;⎕IO;i
  ⎕IO←0

  :For i :In ⌽⍳8
      drawtriangle i odata ondex shadeType
  :EndFor
∇

∇ glutWireOctahedron
  octahedron #.GL.GL_LINE_LOOP
∇

∇ glutSolidOctahedron
  octahedron #.GL.GL_TRIANGLES
∇

∇ initIcosahedron;X;Xm;Z;Zm
  Xm←-X←0.525731112119133606
  Zm←-Z←0.850650808352039932
  idata←12 3⍴Xm 0 Z X 0 Z Xm 0 Zm X 0 Zm 0 Z X 0 Z Xm 0 Zm X 0 Zm Xm Z X 0 Zm X 0 Z Xm 0 Zm Xm 0
  index←20 3⍴0 4 1 0 9 4 9 5 4 4 5 8 4 8 1 8 10 1 8 3 10 5 3 8 5 2 3 2 7 3 7 10 3 7 6 10 7 11 6 11 0 6 0 1 6 6 1 10 9 0 11 9 11 2 9 2 5 7 2 11
∇

∇ la icosahedron shadeType;⎕IO
  ⎕IO←0

  :If 0=⎕NC'idata'
      initIcosahedron
  :EndIf
  :For i :In ⌽⍳20
      drawtriangle i idata index shadeType
  :EndFor
∇

∇ glutWireIcosahedron
  icosahedron #.GL.GL_LINE_LOOP
∇

∇ glutSolidIcosahedron
  icosahedron #.GL.GL_TRIANGLES
∇

∇ initTetrahedron;T;Tm
  Tm←-T←1.73205080756887729
  tdata←4 3⍴T T T T Tm Tm Tm T Tm Tm Tm T
  tndex←4 3⍴0 1 3 2 1 0 3 2 0 1 2 3
∇

∇ tetrahedron shadeType;⎕IO
  ⎕IO←0

  :If 0=⎕NC'tdata'
      initTetrahedron
  :EndIf
  :For i :In ⌽⍳4
      drawtriangle i tdata tndex shadeType
  :EndFor
∇

∇ glutWireTetrahedron
  tetrahedron #.GL.GL_LINE_LOOP
∇

∇ glutSolidTetrahedron
  tetrahedron #.GL.GL_TRIANGLES
∇

patchdata←⊂102 103 104 105 4 5 6 7 8 9 10 11 12 13 14 15 ⍝ rim
patchdata,←⊂12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 ⍝ body
patchdata,←⊂24 25 26 27 29 30 31 32 33 34 35 36 37 38 39 40 ⍝ body
patchdata,←⊂96 96 96 96 97 98 99 100 101 101 101 101 0 1 2 3 ⍝ lid
patchdata,←⊂0 1 2 3 106 107 108 109 110 111 112 113 114 115 116 117 ⍝ lid
patchdata,←⊂118 118 118 118 124 122 119 121 123 126 125 120 40 39 38 37 ⍝ bottom
patchdata,←⊂41 42 43 44 45 46 47 48 49 50 51 52 53 54 55 56 ⍝ handle
patchdata,←⊂53 54 55 56 57 58 59 60 61 62 63 64 28 65 66 67 ⍝ handle
patchdata,←⊂68 69 70 71 72 73 74 75 76 77 78 79 80 81 82 83 ⍝ spout
patchdata,←⊂80 81 82 83 84 85 86 87 88 89 90 91 92 93 94 95 ⍝ spout
patchdata←⊃patchdata

cpdata←(0.2 0 2.7)(0.2 ¯0.112 2.7)(0.112 ¯0.2 2.7)(0 ¯0.2 2.7)(1.3375 0 2.53125)
cpdata,←(1.3375 ¯0.749 2.53125)(0.749 ¯1.3375 2.53125)(0 ¯1.3375 2.53125)
cpdata,←(1.4375 0 2.53125)(1.4375 ¯0.805 2.53125)(0.805 ¯1.4375 2.53125)
cpdata,←(0 ¯1.4375 2.53125)(1.5 0 2.4)(1.5 ¯0.84 2.4)(0.84 ¯1.5 2.4)(0 ¯1.5 2.4)
cpdata,←(1.75 0 1.875)(1.75 ¯0.98 1.875)(0.98 ¯1.75 1.875)(0 ¯1.75 1.875)(2 0 1.35)
cpdata,←(2 ¯1.12 1.35)(1.12 ¯2 1.35)(0 ¯2 1.35)(2 0 0.9)(2 ¯1.12 0.9)(1.12 ¯2 0.9)
cpdata,←(0 ¯2 0.9)(¯2 0 0.9)(2 0 0.45)(2 ¯1.12 0.45)(1.12 ¯2 0.45)(0 ¯2 0.45)
cpdata,←(1.5 0 0.225)(1.5 ¯0.84 0.225)(0.84 ¯1.5 0.225)(0 ¯1.5 0.225)(1.5 0 0.15)
cpdata,←(1.5 ¯0.84 0.15)(0.84 ¯1.5 0.15)(0 ¯1.5 0.15)(¯1.6 0 2.025)(¯1.6 ¯0.3 2.025)
cpdata,←(¯1.5 ¯0.3 2.25)(¯1.5 0 2.25)(¯2.3 0 2.025)(¯2.3 ¯0.3 2.025)(¯2.5 ¯0.3 2.25)
cpdata,←(¯2.5 0 2.25)(¯2.7 0 2.025)(¯2.7 ¯0.3 2.025)(¯3 ¯0.3 2.25)(¯3 0 2.25)
cpdata,←(¯2.7 0 1.8)(¯2.7 ¯0.3 1.8)(¯3 ¯0.3 1.8)(¯3 0 1.8)(¯2.7 0 1.575)
cpdata,←(¯2.7 ¯0.3 1.575)(¯3 ¯0.3 1.35)(¯3 0 1.35)(¯2.5 0 1.125)(¯2.5 ¯0.3 1.125)
cpdata,←(¯2.65 ¯0.3 0.9375)(¯2.65 0 0.9375)(¯2 ¯0.3 0.9)(¯1.9 ¯0.3 0.6)(¯1.9 0 0.6)
cpdata,←(1.7 0 1.425)(1.7 ¯0.66 1.425)(1.7 ¯0.66 0.6)(1.7 0 0.6)(2.6 0 1.425)
cpdata,←(2.6 ¯0.66 1.425)(3.1 ¯0.66 0.825)(3.1 0 0.825)(2.3 0 2.1)(2.3 ¯0.25 2.1)
cpdata,←(2.4 ¯0.25 2.025)(2.4 0 2.025)(2.7 0 2.4)(2.7 ¯0.25 2.4)(3.3 ¯0.25 2.4)
cpdata,←(3.3 0 2.4)(2.8 0 2.475)(2.8 ¯0.25 2.475)(3.525 ¯0.25 2.49375)
cpdata,←(3.525 0 2.49375)(2.9 0 2.475)(2.9 ¯0.15 2.475)(3.45 ¯0.15 2.5125)
cpdata,←(3.45 0 2.5125)(2.8 0 2.4)(2.8 ¯0.15 2.4)(3.2 ¯0.15 2.4)(3.2 0 2.4)
cpdata,←(0 0 3.15)(0.8 0 3.15)(0.8 ¯0.45 3.15)(0.45 ¯0.8 3.15)(0 ¯0.8 3.15)
cpdata,←(0 0 2.85)(1.4 0 2.4)(1.4 ¯0.784 2.4)(0.784 ¯1.4 2.4)(0 ¯1.4 2.4)
cpdata,←(0.4 0 2.55)(0.4 ¯0.224 2.55)(0.224 ¯0.4 2.55)(0 ¯0.4 2.55)(1.3 0 2.55)
cpdata,←(1.3 ¯0.728 2.55)(0.728 ¯1.3 2.55)(0 ¯1.3 2.55)(1.3 0 2.4)(1.3 ¯0.728 2.4)
cpdata,←(0.728 ¯1.3 2.4)(0 ¯1.3 2.4)(0 0 0)(1.425 ¯0.798 0)(1.5 0 0.075)(1.425 0 0)
cpdata,←(0.798 ¯1.425 0)(0 ¯1.5 0.075)(0 ¯1.425 0)(1.5 ¯0.84 0.075)(0.84 ¯1.5 0.075)
cpdata←⊃cpdata

tex←((0 0)(1 0))((0 1)(1 1))

∇ z←teapot (grid scale type);⎕IO;p;q;r;s;i;j;k;l
  ⎕IO←0
  p←q←r←s←4 4 3⍴0

  #.GL.glPushAttrib #.GL.GL_ENABLE_BIT+#.GL.GL_EVAL_BIT
  #.GL.glEnable #.GL.GL_AUTO_NORMAL
  #.GL.glEnable #.GL.GL_NORMALIZE
  #.GL.glEnable #.GL.GL_MAP2_VERTEX_3
  #.GL.glEnable #.GL.GL_MAP2_TEXTURE_COORD_2
  #.GL.glPushMatrix
  #.GL.glRotatef 270 1 0 0
  #.GL.glScalef 0.5 0.5 0.5×scale
  #.GL.glTranslatef 0 0 ¯1.5
  :For i :In ⍳10
      :For j :In ⍳4
          :For k :In ⍳4
              :For l :In ⍳3
                  p[j;k;l]←cpdata[patchdata[i;(j×4)+k];l]
                  q[j;k;l]←cpdata[patchdata[i;(j×4)+(3-k)];l]
                  :If l=1
                      q[j;k;l]×←¯1
                  :EndIf
                  :If i<6
                      r[j;k;l]←cpdata[patchdata[i;(j×4)+(3-k)];l]
                      :If l=0
                          r[j;k;l]×←¯1
                      :EndIf
                      s[j;k;l]←cpdata[patchdata[i;(j×4)+k];l]
                      :If l=0
                          s[j;k;l]×←¯1
                      :EndIf
                      :If l=1
                          s[j;k;l]×←¯1
                      :EndIf
                  :EndIf
              :EndFor
          :EndFor
      :EndFor
      #.GL.glMap2f #.GL.GL_MAP2_TEXTURE_COORD_2 0 1 2 2 0 1 4 2 (∊tex)
      #.GL.glMap2f #.GL.GL_MAP2_VERTEX_3 0 1 3 4 0 1 12 4 (∊p)
      #.GL.glMapGrid2f grid 0 1 grid 0 1
      #.GL.glEvalMesh2 type 0 grid 0 grid
      #.GL.glMap2f #.GL.GL_MAP2_VERTEX_3 0 1 3 4 0 1 12 4 (∊q)
      #.GL.glEvalMesh2 type 0 grid 0 grid
      :If i<6
          #.GL.glMap2f #.GL.GL_MAP2_VERTEX_3 0 1 3 4 0 1 12 4 (∊r)
          #.GL.glEvalMesh2 type 0 grid 0 grid
          #.GL.glMap2f #.GL.GL_MAP2_VERTEX_3 0 1 3 4 0 1 12 4 (∊s)
          #.GL.glEvalMesh2 type 0 grid 0 grid
      :EndIf
  :EndFor
  #.GL.glPopMatrix
  #.GL.glPopAttrib
∇

∇ glutSolidTeapot scale
  teapot 14 scale #.GL.GL_FILL
∇

∇ glutWireTeapot scale
  teapot 10 scale #.GL.GL_LINE
∇

:EndNamespace
