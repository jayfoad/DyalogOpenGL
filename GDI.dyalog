:Namespace GDI

∇ {z}←ChoosePixelFormat x
 :If 3≠⎕NC'ChoosePixelFormat_DLL'
     'ChoosePixelFormat_DLL'⎕NA'I4 gdi32.DLL|ChoosePixelFormat U4 <{U2 U2 U4 I1[20] U4 U4 U4}'
 :EndIf
 z←ChoosePixelFormat_DLL x
∇

∇ {z}←SetPixelFormat x
 :If 3≠⎕NC'SetPixelFormat_DLL'
     'SetPixelFormat_DLL'⎕NA'I4 gdi32.DLL|SetPixelFormat U4 I4 <{U2 U2 U4 I1[20] U4 U4 U4}'
 :EndIf
 z←SetPixelFormat_DLL x
∇

∇ {z}←SwapBuffers x
 :If 3≠⎕NC'SwapBuffers_DLL'
     'SwapBuffers_DLL'⎕NA'I4 gdi32.DLL|SwapBuffers U4'
 :EndIf
 z←SwapBuffers_DLL x
∇

:EndNamespace
