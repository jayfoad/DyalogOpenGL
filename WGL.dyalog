:Namespace WGL

WGL_FONT_LINES←0
WGL_FONT_POLYGONS←1

∇ {z}←wglCreateContext x
 :If 3≠⎕NC'wglCreateContext_DLL'
     'wglCreateContext_DLL'⎕NA'U4 OpenGL32.DLL|wglCreateContext U4'
 :EndIf
 z←wglCreateContext_DLL x
∇

∇ {z}←wglDeleteContext x
 :If 3≠⎕NC'wglDeleteContext_DLL'
     'wglDeleteContext_DLL'⎕NA'U4 OpenGL32.DLL|wglDeleteContext U4'
 :EndIf
 z←wglDeleteContext_DLL x
∇

∇ {z}←wglGetCurrentContext
 :If 3≠⎕NC'wglGetCurrentContext_DLL'
     'wglGetCurrentContext_DLL'⎕NA'U4 OpenGL32.DLL|wglGetCurrentContext'
 :EndIf
 z←wglGetCurrentContext_DLL
∇

∇ {z}←wglGetCurrentDC
 :If 3≠⎕NC'wglGetCurrentDC_DLL'
     'wglGetCurrentDC_DLL'⎕NA'U4 OpenGL32.DLL|wglGetCurrentDC'
 :EndIf
 z←wglGetCurrentDC_DLL
∇

∇ {z}←wglMakeCurrent x
 :If 3≠⎕NC'wglMakeCurrent_DLL'
     'wglMakeCurrent_DLL'⎕NA'U4 OpenGL32.DLL|wglMakeCurrent U4 U4'
 :EndIf
 z←wglMakeCurrent_DLL x
∇

∇ {z}←wglShareLists x
 :If 3≠⎕NC'wglShareLists_DLL'
     'wglShareLists_DLL'⎕NA'U1 OpenGL32.DLL|wglShareLists U4 U4'
 :EndIf
 z←wglShareLists_DLL x
∇

∇ {z}←wglUseFontBitmapsA x
 :If 3≠⎕NC'wglUseFontBitmapsA_DLL'
     'wglUseFontBitmapsA_DLL'⎕NA'I4 OpenGL32.DLL|wglUseFontBitmapsA U4 I4 I4 I4'
 :EndIf
 z←wglUseFontBitmapsA_DLL x
∇

∇ {z}←wglUseFontOutlinesA x
 :If 3≠⎕NC'wglUseFontOutlinesA_DLL'
     'wglUseFontOutlinesA_DLL'⎕NA'I4 OpenGL32.DLL|wglUseFontOutlinesA U4 I4 I4 I4 F4 F4 I4 I4'
 :EndIf
 z←wglUseFontOutlinesA_DLL x
∇

:EndNamespace
