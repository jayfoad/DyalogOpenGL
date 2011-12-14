:Namespace User32

∇ {z}←GetDC x
 :If 3≠⎕NC'GetDC_DLL'
     'GetDC_DLL'⎕NA'U4 USER32.DLL|GetDC U4'
 :EndIf
 z←GetDC_DLL x
∇

∇ {z}←ReleaseDC x
 :If 3≠⎕NC'ReleaseDC_DLL'
     'ReleaseDC_DLL'⎕NA'U4 USER32.DLL|ReleaseDC U4 U4'
 :EndIf
 z←ReleaseDC_DLL x
∇

:EndNamespace
