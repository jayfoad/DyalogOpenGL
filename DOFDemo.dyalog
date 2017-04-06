:Namespace DOFDemo

⍝ Converted from the "dof" sample program from the OpenGL v1.1 Programming Guide
⍝ (Redbook).
⍝
⍝ See http://www.opengl.org/resources/code/samples/redbook/

⍝ N.B. this demo uses the accumulation buffer, a feature which was removed from
⍝ OpenGL in version 3.2.

⍝ Dependencies
⍝∇:require =/GL
⍝∇:require =/GLUT

j8←8 2⍴¯0.334818 0.435331 0.286438 ¯0.393495 0.459462 0.141540 ¯0.414498 ¯0.192829 ¯0.183790 0.082102 ¯0.079263 ¯0.317383 0.102254 0.299133 0.164216 ¯0.054399

∇ accFrustum (left right bottom top near far pixdx pixdy eyedx eyedy focus);⎕IO;viewport;xwsize;ywsize;dx;dy
  ⎕IO←0
  viewport←0 0 0 0

  viewport←#.GL.glGetIntegerv #.GL.GL_VIEWPORT 4

  xwsize←right-left
  ywsize←top-bottom

  dx←-((pixdx×xwsize)÷viewport[2])+(eyedx×near)÷focus
  dy←-((pixdy×ywsize)÷viewport[3])+(eyedy×near)÷focus

  #.GL.glMatrixMode #.GL.GL_PROJECTION
  #.GL.glLoadIdentity
  #.GL.glFrustum (left+dx) (right+dx) (bottom+dy) (top+dy) near far
  #.GL.glMatrixMode #.GL.GL_MODELVIEW
  #.GL.glLoadIdentity
  #.GL.glTranslatef -(eyedx eyedy 0)
∇

∇ accPerspective (fovy aspect near far pixdx pixdy eyedx eyedy focus);fov2;top;bottom;right;left
  fov2←((○fovy)÷180)÷2

  top←near÷((2○fov2)÷(1○fov2))
  bottom←-top

  right←top×aspect
  left←-right

  accFrustum left right bottom top near far pixdx pixdy eyedx eyedy focus
∇

∇ init;ambient;diffuse;specular;position;lmodel_ambient;local_view
  ambient←0 0 0 1
  diffuse←1 1 1 1
  specular←1 1 1 1
  position←0 3 3 0

  lmodel_ambient←0.2 0.2 0.2 1.0
  local_view←0

  #.GL.glLightfv #.GL.GL_LIGHT0 #.GL.GL_AMBIENT ambient
  #.GL.glLightfv #.GL.GL_LIGHT0 #.GL.GL_DIFFUSE diffuse
  #.GL.glLightfv #.GL.GL_LIGHT0 #.GL.GL_POSITION position

  #.GL.glLightModelfv #.GL.GL_LIGHT_MODEL_AMBIENT lmodel_ambient
  #.GL.glLightModelfv #.GL.GL_LIGHT_MODEL_LOCAL_VIEWER local_view

  #.GL.glFrontFace #.GL.GL_CW
  #.GL.glEnable #.GL.GL_LIGHTING
  #.GL.glEnable #.GL.GL_LIGHT0
  #.GL.glEnable #.GL.GL_AUTO_NORMAL
  #.GL.glEnable #.GL.GL_NORMALIZE
  #.GL.glEnable #.GL.GL_DEPTH_TEST

  #.GL.glClearColor 0 0 0 0
  #.GL.glClearAccum 0 0 0 0
  ⍝ make teapot display list
  teapotList←#.GL.glGenLists 1
  #.GL.glNewList teapotList #.GL.GL_COMPILE
  #.GLUT.glutSolidTeapot 0.5
  #.GL.glEndList
∇

∇ renderTeapot (pos amb dif spec shine);mat
  #.GL.glPushMatrix
  #.GL.glTranslatef pos
  #.GL.glMaterialfv #.GL.GL_FRONT #.GL.GL_AMBIENT amb
  #.GL.glMaterialfv #.GL.GL_FRONT #.GL.GL_DIFFUSE dif
  #.GL.glMaterialfv #.GL.GL_FRONT #.GL.GL_SPECULAR spec
  #.GL.glMaterialf #.GL.GL_FRONT #.GL.GL_SHININESS (shine×128)
  #.GL.glCallList teapotList
  #.GL.glPopMatrix
∇

∇ display msg;⎕IO;viewport;jitter
  ⎕IO←0

  viewport←#.GL.glGetIntegerv #.GL.GL_VIEWPORT 4
  #.GL.glClear #.GL.GL_ACCUM_BUFFER_BIT

  :For jitter :In ⍳8
      #.GL.glClear #.GL.GL_COLOR_BUFFER_BIT+#.GL.GL_DEPTH_BUFFER_BIT
      accPerspective 45 (viewport[2]÷viewport[3]) 1 15 0 0,(0.33×j8[jitter;]),5

      ⍝ ruby, gold, silver, emerald, and cyan teapots
      renderTeapot (¯1.1 ¯0.5 ¯4.5) (0.1745  0.01175 0.01175 1) (0.61424 0.04136    0.04136    1) (0.727811   0.626959   0.626959   1) 0.6
      renderTeapot (¯0.5 ¯0.5 ¯5.0) (0.24725 0.1995  0.0745  1) (0.75164 0.60648    0.22648    1) (0.628281   0.555802   0.366065   1) 0.4
      renderTeapot ( 0.2 ¯0.5 ¯5.5) (0.19225 0.19225 0.19225 1) (0.50754 0.50754    0.50754    1) (0.508273   0.508273   0.508273   1) 0.4
      renderTeapot ( 1.0 ¯0.5 ¯6.0) (0.0215  0.1745  0.0215  1) (0.07568 0.61424    0.07568    1) (0.633      0.727811   0.633      1) 0.6
      renderTeapot ( 1.8 ¯0.5 ¯6.5) (0.0     0.1     0.06    1) (0.0     0.50980392 0.50980392 1) (0.50196078 0.50196078 0.50196078 1) 0.25
      #.GL.glAccum #.GL.GL_ACCUM 0.125
  :EndFor
  #.GL.glAccum #.GL.GL_RETURN 1
  #.GL.glFlush
  #.GLUT.glutSwapBuffers
∇

∇ reshape (w h)
  #.GL.glViewport 0 0 w h
∇

∇ keyboard msg;⎕IO
  ⎕IO←0

  :If 'EP'≡2⊃msg
      ⎕NQ (⊃msg) 'Close'
  :EndIf
∇

∇ main;teapotList
  #.GLUT.glutInit
  #.GLUT.glutInitDisplayMode #.GLUT.GLUT_DOUBLE+#.GLUT.GLUT_RGB+#.GLUT.GLUT_ACCUM+#.GLUT.GLUT_DEPTH
  #.GLUT.glutInitWindowSize 400 400
  #.GLUT.glutInitWindowPosition 100 100
  #.GLUT.glutCreateWindow 'Depth of Field Demo'
  init
  #.GLUT.glutReshapeFunc '#.DOFDemo.reshape'
  #.GLUT.glutDisplayFunc '#.DOFDemo.display'
  #.GLUT.glutKeyboardFunc '#.DOFDemo.keyboard'
  #.GLUT.glutMainLoop
∇

:EndNamespace
