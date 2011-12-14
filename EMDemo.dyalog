:Namespace EMDemo

⍝ Converted from "OpenGL Demo II: Cubic Environment Map Reflection".
⍝ See http://usuarios.multimania.es/hernandp/opengl.html

⍝ Dependencies
⍝∇:require =/GL
⍝∇:require =/GLU
⍝∇:require =/GLUT
⍝∇:require =/IL

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

⍝ teapot material
matamb←0 0 0 0
matspec←1 1 1 0
matdif←1 1 1 0
matsh←10

rot_y←0
rot_x←0

∇ main
  #.GLUT.glutInit
  #.IL.ilInit
  #.IL.iluInit
  #.IL.ilutInit
  #.IL.ilutRenderer #.IL.ILUT_OPENGL

  #.IL.ilutEnable #.IL.ILUT_OPENGL_CONV

  openWindow

  freetextures
∇

∇ openWindow;extnames
  #.GLUT.glutInitDisplayMode #.GLUT.GLUT_RGBA+#.GLUT.GLUT_DOUBLE+#.GLUT.GLUT_DEPTH
  ⍝#.GLUT.glutInitWindowPosition 0 0
  #.GLUT.glutInitWindowSize 640 480

  #.GLUT.glutCreateWindow 'Environment Mapping Demo'

  :If ~(#.GLUT.glutExtensionSupported 'GL_ARB_texture_cube_map')∨(#.GLUT.glutExtensionSupported 'GL_EXT_texture_cube_map')
  :OrIf ~#.GLUT.glutExtensionSupported 'GL_SGIS_generate_mipmap'
      MessageBox ('This program needs the following OpenGL extensions:' 'GL_ARB_texture_cube_map' 'GL_SGIS_generate_mipmap') 'Fatal error' 'Error'
      ⍝ TODO exit(-1)
  :EndIf

  initGLparam

  #.GLUT.glutReshapeFunc '#.EMDemo.resizefunc'
  #.GLUT.glutDisplayFunc '#.EMDemo.displayfunc'
  #.GLUT.glutKeyboardFunc '#.EMDemo.keybfunc'
  ⍝#.GLUT.glutIdleFunc '#.EMDemo.idlefunc'

  #.GLUT.glutMainLoop
∇

∇ initGLparam
  #.GL.glShadeModel #.GL.GL_SMOOTH

  #.GL.glClearColor 0 0 0 0
  #.GL.glDepthFunc #.GL.GL_LEQUAL
  #.GL.glClearDepth 1
  #.GL.glEnable #.GL.GL_DEPTH_TEST

  #.GL.glHint #.GL.GL_PERSPECTIVE_CORRECTION_HINT #.GL.GL_NICEST

  #.GL.glLightModelf #.GL.GL_LIGHT_MODEL_LOCAL_VIEWER 1
  #.GL.glLightfv #.GL.GL_LIGHT0 #.GL.GL_SPECULAR spec_0
  #.GL.glLightfv #.GL.GL_LIGHT0 #.GL.GL_AMBIENT amb_0
  #.GL.glLightfv #.GL.GL_LIGHT0 #.GL.GL_DIFFUSE dif_0
  #.GL.glLightfv #.GL.GL_LIGHT0 #.GL.GL_POSITION pos_0
  #.GL.glLightf #.GL.GL_LIGHT0 #.GL.GL_SPOT_EXPONENT exp_0
  #.GL.glEnable #.GL.GL_LIGHT0

  setuptextures
∇

∇ idlefunc
  #.GLUT.glutPostRedisplay
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

  ⍝ teapot texture

  #.IL.ilBindImage xpos
  #.GL.glTexImage2D #.GL.GL_TEXTURE_CUBE_MAP_POSITIVE_X_EXT 0 #.GL.GL_RGB8 256 256 0 #.GL.GL_BGR_EXT #.GL.GL_UNSIGNED_BYTE #.IL.ilGetData

  #.IL.ilBindImage ypos
  #.GL.glTexImage2D #.GL.GL_TEXTURE_CUBE_MAP_POSITIVE_Y_EXT 0 #.GL.GL_RGB8 256 256 0 #.GL.GL_BGR_EXT #.GL.GL_UNSIGNED_BYTE #.IL.ilGetData

  #.IL.ilBindImage zpos
  #.GL.glTexImage2D #.GL.GL_TEXTURE_CUBE_MAP_POSITIVE_Z_EXT 0 #.GL.GL_RGB8 256 256 0 #.GL.GL_BGR_EXT #.GL.GL_UNSIGNED_BYTE #.IL.ilGetData

  #.IL.ilBindImage xneg
  #.GL.glTexImage2D #.GL.GL_TEXTURE_CUBE_MAP_NEGATIVE_X_EXT 0 #.GL.GL_RGB8 256 256 0 #.GL.GL_BGR_EXT #.GL.GL_UNSIGNED_BYTE #.IL.ilGetData

  #.IL.ilBindImage yneg
  #.GL.glTexImage2D #.GL.GL_TEXTURE_CUBE_MAP_NEGATIVE_Y_EXT 0 #.GL.GL_RGB8 256 256 0 #.GL.GL_BGR_EXT #.GL.GL_UNSIGNED_BYTE #.IL.ilGetData

  #.IL.ilBindImage zneg
  #.GL.glTexImage2D #.GL.GL_TEXTURE_CUBE_MAP_NEGATIVE_Z_EXT 0 #.GL.GL_RGB8 256 256 0 #.GL.GL_BGR_EXT #.GL.GL_UNSIGNED_BYTE #.IL.ilGetData

  #.GL.glTexParameteri #.GL.GL_TEXTURE_CUBE_MAP_EXT #.GL.GL_TEXTURE_MIN_FILTER #.GL.GL_LINEAR_MIPMAP_LINEAR
  #.GL.glTexParameteri #.GL.GL_TEXTURE_CUBE_MAP_EXT #.GL.GL_TEXTURE_MAG_FILTER #.GL.GL_LINEAR
  #.GL.glTexParameteri #.GL.GL_TEXTURE_CUBE_MAP_EXT #.GL.GL_GENERATE_MIPMAP_SGIS #.GL.GL_TRUE
  #.GL.glTexParameteri #.GL.GL_TEXTURE_CUBE_MAP_EXT #.GL.GL_TEXTURE_WRAP_S #.GL.GL_CLAMP_TO_EDGE
  #.GL.glTexParameteri #.GL.GL_TEXTURE_CUBE_MAP_EXT #.GL.GL_TEXTURE_WRAP_T #.GL.GL_CLAMP_TO_EDGE

  #.GL.glTexGeni #.GL.GL_S #.GL.GL_TEXTURE_GEN_MODE #.GL.GL_REFLECTION_MAP_EXT
  #.GL.glTexGeni #.GL.GL_T #.GL.GL_TEXTURE_GEN_MODE #.GL.GL_REFLECTION_MAP_EXT
  #.GL.glTexGeni #.GL.GL_R #.GL.GL_TEXTURE_GEN_MODE #.GL.GL_REFLECTION_MAP_EXT

  #.GL.glEnable #.GL.GL_TEXTURE_GEN_S
  #.GL.glEnable #.GL.GL_TEXTURE_GEN_T
  #.GL.glEnable #.GL.GL_TEXTURE_GEN_R
  #.GL.glEnable #.GL.GL_TEXTURE_CUBE_MAP_EXT

  ⍝ draw teapot

  #.GLUT.glutSolidTeapot 1

  ⍝ draw background

  #.GL.glDisable #.GL.GL_TEXTURE_GEN_S
  #.GL.glDisable #.GL.GL_TEXTURE_GEN_T
  #.GL.glDisable #.GL.GL_TEXTURE_GEN_R
  #.GL.glDisable #.GL.GL_TEXTURE_CUBE_MAP_EXT

  #.GL.glLoadIdentity

  ⍝ background texture

  #.GL.glEnable #.GL.GL_TEXTURE_2D
  #.GL.glDisable #.GL.GL_LIGHTING

  #.IL.ilBindImage back
  #.GL.glBindTexture   #.GL.GL_TEXTURE_2D back
  #.GL.glTexParameteri #.GL.GL_TEXTURE_2D #.GL.GL_GENERATE_MIPMAP_SGIS #.GL.GL_TRUE
  #.GL.glTexParameteri #.GL.GL_TEXTURE_2D #.GL.GL_TEXTURE_MIN_FILTER #.GL.GL_LINEAR_MIPMAP_LINEAR
  #.GL.glTexParameteri #.GL.GL_TEXTURE_2D #.GL.GL_TEXTURE_MAG_FILTER #.GL.GL_LINEAR
  #.GL.glTexImage2D    #.GL.GL_TEXTURE_2D 0 #.GL.GL_RGB8 512 512 0 (#.IL.ilGetInteger #.IL.IL_IMAGE_FORMAT) #.GL.GL_UNSIGNED_BYTE #.IL.ilGetData

  #.GL.glBegin #.GL.GL_QUADS
      #.GL.glColor3f 1 1 1
      #.GL.glNormal3f 1 1 1
      #.GL.glTexCoord2f ¯1 ¯1 ⋄ #.GL.glVertex3f ¯3.9 ¯3.0 ¯7.0
      #.GL.glTexCoord2f  0 ¯1 ⋄ #.GL.glVertex3f  3.9 ¯3.0 ¯7.0
      #.GL.glTexCoord2f  0  0 ⋄ #.GL.glVertex3f  3.9  3.0 ¯7.0
      #.GL.glTexCoord2f ¯1  0 ⋄ #.GL.glVertex3f ¯3.9  3.0 ¯7.0
  #.GL.glEnd

  ⍝ swap

  #.GLUT.glutSwapBuffers
∇

∇ setuptextures;path
  path←{(⌽∨\⌽(⍵='\')∨⍵='/')/⍵} SALT_Data.SourceFile

  xpos←#.IL.ilGenImages 1
  #.IL.ilBindImage xpos
  #.IL.ilLoadImage path,'xpos.bmp'

  ypos←#.IL.ilGenImages 1
  #.IL.ilBindImage ypos
  #.IL.ilLoadImage path,'ypos.bmp'

  zpos←#.IL.ilGenImages 1
  #.IL.ilBindImage zpos
  #.IL.ilLoadImage path,'zpos.bmp'

  xneg←#.IL.ilGenImages 1
  #.IL.ilBindImage xneg
  #.IL.ilLoadImage path,'xneg.bmp'

  yneg←#.IL.ilGenImages 1
  #.IL.ilBindImage yneg
  #.IL.ilLoadImage path,'yneg.bmp'

  zneg←#.IL.ilGenImages 1
  #.IL.ilBindImage zneg
  #.IL.ilLoadImage path,'zneg.bmp'

  back←#.IL.ilGenImages 1
  #.IL.ilBindImage back
  #.IL.ilLoadImage path,'back.bmp'
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
  #.IL.ilDeleteImages xpos
  #.IL.ilDeleteImages zpos
  #.IL.ilDeleteImages ypos
  #.IL.ilDeleteImages xneg
  #.IL.ilDeleteImages yneg
  #.IL.ilDeleteImages zneg
∇

:EndNamespace
