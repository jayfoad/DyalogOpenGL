:Namespace EMDemo

⍝ Converted from "OpenGL Demo II: Cubic Environment Map Reflection".
⍝ See http://usuarios.multimania.es/hernandp/opengl.html

⍝ Dependencies
⍝∇:require =/GL
⍝∇:require =/GLU
⍝∇:require =/GLUT-X
⍝∇:require =/GLDuck

⎕ML←0
⎕IO←0

∇ MessageBox (text caption type);msg
  msg←⎕NEW 'MsgBox' (('Caption' caption) ('Text' text) ('Style' type) ('Btns' 'OK'))
  ⎕DQ msg
∇

⍝ lights
spec_0←1 1 1 1
amb_0←0.2 0.2 0.2 1
dif_0←1 1 1 1
pos_0←0 1 0 1
exp_0←128

∇ main;rot_y;rot_x;cube;back;disp
  rot_y←0
  rot_x←0

  #.GLUT.glutInit

  openWindow

  freetextures
∇

∇ openWindow;version
  #.GLUT.glutInitDisplayMode #.GLUT.GLUT_RGBA+#.GLUT.GLUT_DOUBLE+#.GLUT.GLUT_DEPTH
  ⍝#.GLUT.glutInitWindowPosition 0 0
  #.GLUT.glutInitWindowSize 640 480

  #.GLUT.glutCreateWindow 'Environment Mapping Demo'

  version←⊃1⊃⎕VFI⊃('^[0-9]+\.[0-9]+' ⎕S '&') #.GL.glGetString #.GL.GL_VERSION

  :If (version<1.2)∧(~#.GLUT.glutExtensionSupported 'GL_EXT_bgra')
  :OrIf (version<1.3)∧(~#.GLUT.glutExtensionSupported 'GL_ARB_texture_cube_map')∧(~#.GLUT.glutExtensionSupported 'GL_EXT_texture_cube_map')
  :OrIf (version<1.4)∧(~#.GLUT.glutExtensionSupported 'GL_SGIS_generate_mipmap')
      MessageBox ('This program needs the following OpenGL extensions:' 'GL_EXT_bgra' 'GL_ARB_texture_cube_map' 'GL_SGIS_generate_mipmap') 'Fatal error' 'Error'
      ⍝ TODO exit(-1)
  :EndIf

  initGLparam

  #.GLUT.glutReshapeFunc '#.EMDemo.resizefunc'
  #.GLUT.glutDisplayFunc '#.EMDemo.displayfunc'
  #.GLUT.glutKeyboardFunc '#.EMDemo.keybfunc'

  #.GLUT.glutMainLoop
∇

∇ initGLparam
  #.GL.glEnable #.GL.GL_DEPTH_TEST

  #.GL.glHint #.GL.GL_PERSPECTIVE_CORRECTION_HINT #.GL.GL_NICEST

  #.GL.glLightModelf #.GL.GL_LIGHT_MODEL_LOCAL_VIEWER 1
  #.GL.glLightfv #.GL.GL_LIGHT0 #.GL.GL_SPECULAR spec_0
  #.GL.glLightfv #.GL.GL_LIGHT0 #.GL.GL_AMBIENT amb_0
  #.GL.glLightfv #.GL.GL_LIGHT0 #.GL.GL_DIFFUSE dif_0
  #.GL.glLightfv #.GL.GL_LIGHT0 #.GL.GL_POSITION pos_0
  #.GL.glLightf #.GL.GL_LIGHT0 #.GL.GL_SPOT_EXPONENT exp_0
  #.GL.glEnable #.GL.GL_LIGHT0

  #.GL.glEnable #.GL.GL_COLOR_MATERIAL

  setuptextures
∇

∇ resizefunc (x y)

  #.GL.glViewport 0 0 x y
  #.GL.glMatrixMode #.GL.GL_PROJECTION
  #.GL.glLoadIdentity

  #.GLU.gluPerspective 45 (x÷y) 2 2000

  #.GL.glMatrixMode #.GL.GL_MODELVIEW
  #.GL.glLoadIdentity
∇

∇ displayfunc
  #.GL.glClear #.GL.GL_COLOR_BUFFER_BIT+#.GL.GL_DEPTH_BUFFER_BIT

  #.GL.glMatrixMode #.GL.GL_MODELVIEW
  #.GL.glLoadIdentity

  #.GL.glTranslatef 0 0 ¯4.5
  #.GL.glRotatef rot_y 0 1 0
  #.GL.glRotatef rot_x 1 0 0

  ⍝ object texture

  #.GL.glBindTexture #.GL.GL_TEXTURE_CUBE_MAP cube

  #.GL.glTexGeni #.GL.GL_S #.GL.GL_TEXTURE_GEN_MODE #.GL.GL_REFLECTION_MAP
  #.GL.glTexGeni #.GL.GL_T #.GL.GL_TEXTURE_GEN_MODE #.GL.GL_REFLECTION_MAP
  #.GL.glTexGeni #.GL.GL_R #.GL.GL_TEXTURE_GEN_MODE #.GL.GL_REFLECTION_MAP

  #.GL.glEnable #.GL.GL_TEXTURE_GEN_S
  #.GL.glEnable #.GL.GL_TEXTURE_GEN_T
  #.GL.glEnable #.GL.GL_TEXTURE_GEN_R
  #.GL.glEnable #.GL.GL_TEXTURE_CUBE_MAP
  #.GL.glEnable #.GL.GL_LIGHTING

  ⍝ draw object

  #.GL.glCallList disp

  ⍝ draw background

  #.GL.glDisable #.GL.GL_TEXTURE_GEN_S
  #.GL.glDisable #.GL.GL_TEXTURE_GEN_T
  #.GL.glDisable #.GL.GL_TEXTURE_GEN_R
  #.GL.glDisable #.GL.GL_TEXTURE_CUBE_MAP

  #.GL.glLoadIdentity

  ⍝ background texture

  #.GL.glEnable #.GL.GL_TEXTURE_2D
  #.GL.glDisable #.GL.GL_LIGHTING

  #.GL.glBindTexture #.GL.GL_TEXTURE_2D back
  #.GL.glBegin #.GL.GL_QUADS
      #.GL.glColor3f 1 1 1
      #.GL.glNormal3f 1 1 1
      #.GL.glTexCoord2f ¯1 ¯1 ⋄ #.GL.glVertex3f ¯3.9 ¯3.0 ¯7.0
      #.GL.glTexCoord2f  0 ¯1 ⋄ #.GL.glVertex3f  3.9 ¯3.0 ¯7.0
      #.GL.glTexCoord2f  0  0 ⋄ #.GL.glVertex3f  3.9  3.0 ¯7.0
      #.GL.glTexCoord2f ¯1  0 ⋄ #.GL.glVertex3f ¯3.9  3.0 ¯7.0
  #.GL.glEnd

  #.GL.glDisable #.GL.GL_TEXTURE_2D

  ⍝ swap

  #.GLUT.glutSwapBuffers
∇

∇ r←loadbmp filename;t
  t←filename ⎕NTIE 0
  r←256|54↓⎕NREAD t 83 (⎕NSIZE t)
  ⎕NUNTIE t
∇

∇ setuptextures;path
  path←{(⌽∨\⌽(⍵='\')∨⍵='/')/⍵} SALT_Data.SourceFile

  cube back←#.GL.glGenTextures 2 2

  #.GL.glBindTexture #.GL.GL_TEXTURE_CUBE_MAP cube

  #.GL.glTexParameteri #.GL.GL_TEXTURE_CUBE_MAP #.GL.GL_TEXTURE_WRAP_S #.GL.GL_CLAMP_TO_EDGE
  #.GL.glTexParameteri #.GL.GL_TEXTURE_CUBE_MAP #.GL.GL_TEXTURE_WRAP_T #.GL.GL_CLAMP_TO_EDGE
  #.GL.glTexParameteri #.GL.GL_TEXTURE_CUBE_MAP #.GL.GL_TEXTURE_WRAP_R #.GL.GL_CLAMP_TO_EDGE
  #.GL.glTexParameteri #.GL.GL_TEXTURE_CUBE_MAP #.GL.GL_TEXTURE_MAG_FILTER #.GL.GL_LINEAR
  #.GL.glTexParameteri #.GL.GL_TEXTURE_CUBE_MAP #.GL.GL_TEXTURE_MIN_FILTER #.GL.GL_LINEAR_MIPMAP_LINEAR
  #.GL.glTexParameteri #.GL.GL_TEXTURE_CUBE_MAP #.GL.GL_GENERATE_MIPMAP #.GL.GL_TRUE

  #.GL.glTexImage2D #.GL.GL_TEXTURE_CUBE_MAP_POSITIVE_X 0 #.GL.GL_RGB8 256 256 0 #.GL.GL_BGR #.GL.GL_UNSIGNED_BYTE (loadbmp path,'xpos.bmp')
  #.GL.glTexImage2D #.GL.GL_TEXTURE_CUBE_MAP_NEGATIVE_X 0 #.GL.GL_RGB8 256 256 0 #.GL.GL_BGR #.GL.GL_UNSIGNED_BYTE (loadbmp path,'xneg.bmp')
  #.GL.glTexImage2D #.GL.GL_TEXTURE_CUBE_MAP_POSITIVE_Y 0 #.GL.GL_RGB8 256 256 0 #.GL.GL_BGR #.GL.GL_UNSIGNED_BYTE (loadbmp path,'ypos.bmp')
  #.GL.glTexImage2D #.GL.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y 0 #.GL.GL_RGB8 256 256 0 #.GL.GL_BGR #.GL.GL_UNSIGNED_BYTE (loadbmp path,'yneg.bmp')
  #.GL.glTexImage2D #.GL.GL_TEXTURE_CUBE_MAP_POSITIVE_Z 0 #.GL.GL_RGB8 256 256 0 #.GL.GL_BGR #.GL.GL_UNSIGNED_BYTE (loadbmp path,'zpos.bmp')
  #.GL.glTexImage2D #.GL.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z 0 #.GL.GL_RGB8 256 256 0 #.GL.GL_BGR #.GL.GL_UNSIGNED_BYTE (loadbmp path,'zneg.bmp')

  #.GL.glBindTexture #.GL.GL_TEXTURE_2D back
  #.GL.glTexParameteri #.GL.GL_TEXTURE_2D #.GL.GL_GENERATE_MIPMAP #.GL.GL_TRUE
  #.GL.glTexParameteri #.GL.GL_TEXTURE_2D #.GL.GL_TEXTURE_MIN_FILTER #.GL.GL_LINEAR_MIPMAP_LINEAR
  #.GL.glTexParameteri #.GL.GL_TEXTURE_2D #.GL.GL_TEXTURE_MAG_FILTER #.GL.GL_LINEAR
  #.GL.glTexImage2D #.GL.GL_TEXTURE_2D 0 #.GL.GL_RGB8 512 512 0 #.GL.GL_BGR #.GL.GL_UNSIGNED_BYTE (loadbmp path,'back.bmp')

  disp←#.GL.glGenLists 1
  #.GL.glNewList disp #.GL.GL_COMPILE
  #.GLDuck.glDucky 1
  #.GL.glEndList
∇

∇ keybfunc (key x y)
  :Select key
  :CaseList 'w' 'W'
      rot_x+←1.4

  :CaseList 's' 'S'
      rot_x-←1.4

  :CaseList 'd' 'D'
      rot_y+←1.4

  :CaseList 'a' 'A'
      rot_y-←1.4
  :EndSelect

  #.GLUT.glutPostRedisplay
∇

∇ freetextures
  #.GL.glDeleteTextures 2 (cube back)
∇

:EndNamespace
