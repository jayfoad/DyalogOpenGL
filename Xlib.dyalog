:Namespace Xlib

⍝ Try:
⍝ d←#.Xlib.XOpenDisplay
⍝ r←#.Xlib.XDefaultRootWindow d
⍝ w←#.Xlib.XCreateSimpleWindow d r 0 0 200 100 0 0 0
⍝ #.Xlib.XSelectInput d w #.Xlib.StructureNotifyMask
⍝ #.Xlib.XMapWindow d w
⍝ {⍵≡#.Xlib.XNextEvent d: ⋄ ∇⍵} #.Xlib.MapNotify

NoEventMask←0
KeyPressMask←2*0
KeyReleaseMask←2*1
ButtonPressMask←2*2
ButtonReleaseMask←2*3
EnterWindowMask←2*4
LeaveWindowMask←2*5
PointerMotionMask←2*6
PointerMotionHintMask←2*7
Button1MotionMask←2*8
Button2MotionMask←2*9
Button3MotionMask←2*10
Button4MotionMask←2*11
Button5MotionMask←2*12
ButtonMotionMask←2*13
KeymapStateMask←2*14
ExposureMask←2*15
VisibilityChangeMask←2*16
StructureNotifyMask←2*17
ResizeRedirectMask←2*18
SubstructureNotifyMask←2*19
SubstructureRedirectMask←2*20
FocusChangeMask←2*21
PropertyChangeMask←2*22
ColormapChangeMask←2*23
OwnerGrabButtonMask←2*24

KeyPress←2
KeyRelease←3
ButtonPress←4
ButtonRelease←5
MotionNotify←6
EnterNotify←7
LeaveNotify←8
FocusIn←9
FocusOut←10
KeymapNotify←11
Expose←12
GraphicsExpose←13
NoExpose←14
VisibilityNotify←15
CreateNotify←16
DestroyNotify←17
UnmapNotify←18
MapNotify←19
MapRequest←20
ReparentNotify←21
ConfigureNotify←22
ConfigureRequest←23
GravityNotify←24
ResizeRequest←25
CirculateNotify←26
CirculateRequest←27
PropertyNotify←28
SelectionClear←29
SelectionRequest←30
SelectionNotify←31
ColormapNotify←32
ClientMessage←33
MappingNotify←34
GenericEvent←35
LASTEvent←36

∇ {z}←XOpenDisplay
 :If 3≠⎕NC'XOpenDisplay_DLL'
     'XOpenDisplay_DLL'⎕NA'P libX11.so|XOpenDisplay P'
 :EndIf
 z←XOpenDisplay_DLL 0
 :If z=0
     ⎕SIGNAL 999 ⍝ ???
 :EndIf
∇

∇ {z}←XDefaultRootWindow x
 :If 3≠⎕NC'XDefaultRootWindow_DLL'
     'XDefaultRootWindow_DLL'⎕NA'P libX11.so|XDefaultRootWindow P'
 :EndIf
 z←XDefaultRootWindow_DLL x
∇

∇ {z}←XDefaultScreen x
 :If 3≠⎕NC'XDefaultScreen_DLL'
     'XDefaultScreen_DLL'⎕NA'I4 libX11.so|XDefaultScreen P'
 :EndIf
 z←XDefaultScreen_DLL x
∇

∇ {z}←XCreateWindow x
 :If 3≠⎕NC'XCreateWindow_DLL'
     'XCreateWindow_DLL'⎕NA'P libX11.so|XCreateWindow P P I4 I4 U4 U4 U4 I4 U4 P P P'
 :EndIf
 z←XCreateWindow_DLL x
 :If z=0
     ⎕SIGNAL 999 ⍝ ???
 :EndIf
∇

∇ {z}←XCreateSimpleWindow x
 :If 3≠⎕NC'XCreateSimpleWindow_DLL'
     'XCreateSimpleWindow_DLL'⎕NA'P libX11.so|XCreateSimpleWindow P P I4 I4 U4 U4 U4 P P'
 :EndIf
 z←XCreateSimpleWindow_DLL x
 :If z=0
     ⎕SIGNAL 999 ⍝ ???
 :EndIf
∇

∇ XSelectInput x
 :If 3≠⎕NC'XSelectInput_DLL'
     'XSelectInput_DLL'⎕NA'libX11.so|I4 XSelectInput P P P'
 :EndIf
 {}XSelectInput_DLL x
∇

∇ XMapWindow x
 :If 3≠⎕NC'XMapWindow_DLL'
     'XMapWindow_DLL'⎕NA'libX11.so|I4 XMapWindow P P'
 :EndIf
 {}XMapWindow_DLL x
∇

∇ {z}←XNextEvent x
 :If 3≠⎕NC'XNextEvent_DLL'
     ⍝ P[24] ensures that this struct isn't smaller than struct XEvent.
     'XNextEvent_DLL'⎕NA'libX11.so|I4 XNextEvent P >{I4 P[24]}'
 :EndIf
 ⍝ Just return the event type for the nonce.
 z←⊃XNextEvent_DLL x 0
∇

∇ XFree x
 :If 3≠⎕NC'XFree_DLL'
     'XFree_DLL'⎕NA'libX11.so|I4 XFree P'
 :EndIf
 {}XFree_DLL x
∇

:EndNamespace
