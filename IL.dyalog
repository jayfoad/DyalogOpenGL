:Namespace IL

⍝ APL implementations of a few functions from the Developer's Image Library,
⍝ DevIL.
⍝
⍝ See http://openil.sourceforge.net/

⍝ I have only implemented just enough to get EMDemo working. --JMF

⍝ Dependencies
⍝∇:require =/GL

⍝ IL ⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

IL_IMAGE_FORMAT←0

imagedata←⍬

∇ ilInit
∇

∇ images←ilGenImages num;⎕IO
  ⎕IO←0
  images←(⊃⍴imagedata)+⍳num
  imagedata,←num⍴⊂⍬
∇

∇ ilBindImage image
  imagenum←image
∇

∇ ilDeleteImages images;⎕IO
  ⎕IO←0
  imagedata[images]←⊂⍬
∇

∇ ilLoadImage filename;⎕IO;t
  ⎕IO←0
  t←filename ⎕NTIE 0
  imagedata[imagenum]←⊂256|54↓⎕NREAD t 83 (⎕NSIZE t)
  ⎕NUNTIE t
∇

∇ data←ilGetData;⎕IO
  ⎕IO←0
  data←imagenum⊃imagedata
∇

∇ r←ilGetInteger mode
  r←#.GL.GL_BGR_EXT
∇

⍝ ILU ⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

∇ iluInit
∇

⍝ ILUT ⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝⍝

ILUT_OPENGL←0
ILUT_OPENGL_CONV←0

∇ ilutInit
∇

∇ ilutRenderer x
∇

∇ ilutEnable x
∇

:EndNamespace
