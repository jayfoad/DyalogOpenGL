:Namespace GLDemo

⍝ Dependencies
⍝∇:require =/GL
⍝∇:require =/GLUT

∇ Demo
  #.GLUT.glutCreateWindow'OpenGL Demo'
  #.GLUT.glutInitWindowPosition 10 10
  #.GLUT.glutInitWindowSize 350 350
  #.GLUT.glutReshapeFunc '#.GLDemo.⍙configure'
  #.GLUT.glutKeyboardFunc '#.GLDemo.⍙key'
  Teapots 99
  #.GLUT.glutDisplayFunc '#.GLDemo.DrawTeapots'
  #.GLUT.glutMainLoop
∇

∇ DrawTeapots;texpts;w
  texpts←1 1 1 0
  w←#.GL.glTexGen(#.GL.GL_S,#.GL.GL_OBJECT_PLANE,⊂texpts)
  #.GLUT.glutSolidTeapot 0.25
  w←#.GL.glTranslatef 0 0.45 0
  texpts←0 1 1 0
  w←#.GL.glTexGen(#.GL.GL_S,#.GL.GL_OBJECT_PLANE,⊂texpts)
  #.GLUT.glutSolidTeapot 0.25
  texpts←0 1 0 0
  w←#.GL.glTranslatef 0 ¯0.9 0
  w←#.GL.glTexGen(#.GL.GL_S,#.GL.GL_OBJECT_PLANE,⊂texpts)
  #.GLUT.glutSolidTeapot 0.25
∇

∇ Teapots n;texpts;imageHeight;imageWidth;image;w
  ⍝ Prepare data for drawing 3 Teapots with different 1D Textures
  texpts←1 1 1 0
  (imageHeight imageWidth)←32
  image←makeStripeImage
  w←#.GL.glMatrixMode(#.GL.GL_MODELVIEW)
  w←#.GL.glLoadIdentity
  w←#.GL.glPixelStore(#.GL.GL_UNPACK_ALIGNMENT,1)
  w←#.GL.glTexEnv(#.GL.GL_TEXTURE_ENV,#.GL.GL_TEXTURE_ENV_MODE,#.GL.GL_MODULATE)
  w←#.GL.glTexParameter(#.GL.GL_TEXTURE_1D,#.GL.GL_TEXTURE_WRAP_S,#.GL.GL_REPEAT)
  w←#.GL.glTexParameter(#.GL.GL_TEXTURE_1D,#.GL.GL_TEXTURE_MAG_FILTER,#.GL.GL_LINEAR)
  w←#.GL.glTexParameter(#.GL.GL_TEXTURE_1D,#.GL.GL_TEXTURE_MIN_FILTER,#.GL.GL_LINEAR)
  w←#.GL.glTexImage1D(#.GL.GL_TEXTURE_1D,0,3,imageWidth,0,#.GL.GL_RGB,#.GL.GL_UNSIGNED_BYTE,⊂image)
  w←#.GL.glTexGen(#.GL.GL_S,#.GL.GL_TEXTURE_GEN_MODE,#.GL.GL_OBJECT_LINEAR)
  w←#.GL.glTexGen(#.GL.GL_S,#.GL.GL_OBJECT_PLANE,⊂texpts)
  w←#.GL.glEnable(#.GL.GL_TEXTURE_1D)
  w←#.GL.glEnable(#.GL.GL_DEPTH_TEST)
  w←#.GL.glEnable(#.GL.GL_NORMALIZE)
  w←#.GL.glCullFace(#.GL.GL_BACK)
  w←#.GL.glEnable(#.GL.GL_TEXTURE_GEN_S)
  w←#.GL.glEnable(#.GL.GL_LIGHTING)
  w←#.GL.glEnable(#.GL.GL_AUTO_NORMAL)
  w←#.GL.glEnable(#.GL.GL_LIGHT0)
  w←#.GL.glFrontFace(#.GL.GL_CW)
  w←#.GL.glEnable(#.GL.GL_CULL_FACE)
  w←#.GL.glMaterial(#.GL.GL_FRONT,#.GL.GL_SHININESS,64)
  DrawTeapots
∇

∇ im←makeStripeImage;i;j;tj;ti;⎕IO
  ⍝ Create 1D Texture
  ⎕IO←0
  im←(3×32)⍴0
  :For i :In ⍳32
      im[3×i]←(255 0)[i≤4]
      im[1+3×i]←(255 0)[i>4]
      im[2+3×i]←0
  :End
  im←⌊im
∇

:EndNamespace
