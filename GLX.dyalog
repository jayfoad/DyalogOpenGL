:Namespace GLX

⍝ See "OpenGL Graphics with the X Window System (Version 1.4)"
⍝ http://www.opengl.org/registry/doc/glx1.4.pdf

⍝ Dependencies
⍝∇:require =/Xlib

GLX_USE_GL←1
GLX_BUFFER_SIZE←2
GLX_LEVEL←3
GLX_RGBA←4
GLX_DOUBLEBUFFER←5
GLX_STEREO←6
GLX_AUX_BUFFERS←7
GLX_RED_SIZE←8
GLX_GREEN_SIZE←9
GLX_BLUE_SIZE←10
GLX_ALPHA_SIZE←11
GLX_DEPTH_SIZE←12
GLX_STENCIL_SIZE←13
GLX_ACCUM_RED_SIZE←14
GLX_ACCUM_GREEN_SIZE←15
GLX_ACCUM_BLUE_SIZE←16
GLX_ACCUM_ALPHA_SIZE←17

GLX_CONFIG_CAVEAT←32
GLX_DONT_CARE←4294967295
GLX_X_VISUAL_TYPE←34
GLX_TRANSPARENT_TYPE←35
GLX_TRANSPARENT_INDEX_VALUE←36
GLX_TRANSPARENT_RED_VALUE←37
GLX_TRANSPARENT_GREEN_VALUE←38
GLX_TRANSPARENT_BLUE_VALUE←39
GLX_TRANSPARENT_ALPHA_VALUE←40
GLX_WINDOW_BIT←1
GLX_PIXMAP_BIT←2
GLX_PBUFFER_BIT←4
GLX_AUX_BUFFERS_BIT←16
GLX_FRONT_LEFT_BUFFER_BIT←1
GLX_FRONT_RIGHT_BUFFER_BIT←2
GLX_BACK_LEFT_BUFFER_BIT←4
GLX_BACK_RIGHT_BUFFER_BIT←8
GLX_DEPTH_BUFFER_BIT←32
GLX_STENCIL_BUFFER_BIT←64
GLX_ACCUM_BUFFER_BIT←128
GLX_NONE←32768
GLX_SLOW_CONFIG←32769
GLX_TRUE_COLOR←32770
GLX_DIRECT_COLOR←32771
GLX_PSEUDO_COLOR←32772
GLX_STATIC_COLOR←32773
GLX_GRAY_SCALE←32774
GLX_STATIC_GRAY←32775
GLX_TRANSPARENT_RGB←32776
GLX_TRANSPARENT_INDEX←32777
GLX_VISUAL_ID←32779
GLX_SCREEN←32780
GLX_NON_CONFORMANT_CONFIG←32781
GLX_DRAWABLE_TYPE←32784
GLX_RENDER_TYPE←32785
GLX_X_RENDERABLE←32786
GLX_FBCONFIG_ID←32787
GLX_RGBA_TYPE←32788
GLX_COLOR_INDEX_TYPE←32789
GLX_MAX_PBUFFER_WIDTH←32790
GLX_MAX_PBUFFER_HEIGHT←32791
GLX_MAX_PBUFFER_PIXELS←32792
GLX_PRESERVED_CONTENTS←32795
GLX_LARGEST_PBUFFER←32796
GLX_WIDTH←32797
GLX_HEIGHT←32798
GLX_EVENT_MASK←32799
GLX_DAMAGED←32800
GLX_SAVED←32801
GLX_WINDOW←32802
GLX_PBUFFER←32803
GLX_PBUFFER_HEIGHT←32832
GLX_PBUFFER_WIDTH←32833
GLX_RGBA_BIT←1
GLX_COLOR_INDEX_BIT←2
GLX_PBUFFER_CLOBBER_MASK←134217728

⍝ 3.3 Functions
⍝ 3.3.1 Initialization

⍝ glXQueryExtension
⍝ glXQueryVersion

⍝ 3.3.2 GLX Versioning

⍝ glXQueryExtensionString
⍝ glXGetClientString

⍝ 3.3.3 Configuration Management

⍝ glXQueryServerString
⍝ glXGetFBConfigs

∇ {z}←glXChooseFBConfig x;p;n
  :If 3≠⎕NC'glXChooseFBConfig_DLL'
      'glXChooseFBConfig_DLL'⎕NA'P libGL.so|glXChooseFBConfig P I4 <I4[] >I4'
  :EndIf
  p n←glXChooseFBConfig_DLL x,0
  :If p=0
      z←⍬
  :Else
      :If 3≠⎕NC'glXChooseFBConfig_copyarray'
          'glXChooseFBConfig_copyarray'⎕NA'P dyalog64.so|MEMCPY >P[] P P' ⍝ FIXME dyalog32 for 32-bit
      :EndIf
      z←⊃⌽glXChooseFBConfig_copyarray n p (n×8) ⍝ FIXME 4 for 32-bit
      #.Xlib.XFree p

      ⍝:If 3≠⎕NC'glXChooseFBConfig_copyfbconfig'
      ⍝    'glXChooseFBConfig_copyfbconfig'⎕NA'P dyalog64.so|MEMCPY >{I4 I4 I4 I4 I4 I4 I4 I4 I4 I4 I4 I4 I4 I4 I4 I4 I4 I4 U4 U1 U1 U1 U1 U1 U1 U1 U1[1] I4 I4 I4 I4 I4 I4 I4 I4 I4 I4 I4 U4 U4 U4 U4 U4 U4 I4 I4 U1 U1[7] F8 F8 F8 F8 F8 F8 F8 F8} P P' ⍝ FIXME dyalog32 for 32-bit
      ⍝:EndIf
      ⍝z←{⊃⌽glXChooseFBConfig_copyfbconfig 0 ⍵ 232}¨z ⍝ FIXME 228 for 32-bit
  :EndIf
∇

⍝ glXGetFBConfigAttrib

∇ {z}←glXGetVisualFromFBConfig x;p
  :If 3≠⎕NC'glXGetVisualFromFBConfig_DLL'
      'glXGetVisualFromFBConfig_DLL'⎕NA'P libGL.so|glXGetVisualFromFBConfig P P'
  :EndIf
  p←glXGetVisualFromFBConfig_DLL x
  :If p=0
      ⎕SIGNAL 999 ⍝ ???
  :EndIf
  :If 3≠⎕NC'glXGetVisualFromFBConfig_copy'
      'glXGetVisualFromFBConfig_copy'⎕NA'P dyalog64.so|MEMCPY >{P P I4 I4 I4 U1[4] P P P I4 I4} P P' ⍝ FIXME dyalog32 for 32-bit
  :EndIf
  z←⎕NS''
  z.(visual visualid screen depth class red_mask green_mask blue_mask colormap_size bits_per_rgb)←1 1 1 1 1 0 1 1 1 1 1/⊃⌽glXGetVisualFromFBConfig_copy 0 p 64 ⍝ FIXME 40 for 32-bit
  #.Xlib.XFree p
∇

⍝ 3.3.4 On Screen Rendering

⍝ glXCreateWindow
⍝ glXDestroyWindow

⍝ 3.3.5 Off Screen Rendering

⍝ glXCreatePixmap
⍝ glXDestroyPixmap
⍝ glXCreatePbuffer
⍝ glXDestroyPbuffer

⍝ 3.3.6 Querying Attributes

⍝ glXQueryDrawable

⍝ 3.3.7 Rendering Contexts

⍝ glXCreateNewContext
⍝ glXIsDirect
⍝ glXDestroyContext
⍝ glXMakeContextCurrent
⍝ glXCopyContext
⍝ glXGetCurrentContext
⍝ glXGetCurrentDrawable
⍝ glXGetCurrentReadDrawable
⍝ glXGetCurrentDisplay
⍝ glXQueryContext

⍝ 3.3.8 Events

⍝ glXSelectEvent
⍝ glXGetSelectedEvent

⍝ 3.3.9 Synchronization Primitives

⍝ glXWaitGL
⍝ glXWaitX

⍝ 3.3.10 Double Buffering

⍝ glXSwapBuffers

⍝ 3.3.11 Access to X Fonts

⍝ glXUseXFont

⍝ 3.3.12 Obtaining Extension Function Pointers

⍝ glXGetProcAddress

⍝ 3.4 Backwards Compatibility
⍝ 3.4.1 Using Visuals for Configuration Management

⍝ glXGetConfig
⍝ glXChooseVisual

⍝ 3.4.2 Off Screen Rendering

⍝ glXCreateGLXPixmap
⍝ glXDestroyGLXPixmap

⍝ 3.5 Rendering Contexts

⍝ glXCreateContext
⍝ glXMakeCurrent

:EndNamespace
