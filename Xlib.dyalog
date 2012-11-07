:Namespace Xlib

⍝ Try:
⍝ d←#.Xlib.XOpenDisplay
⍝ r←#.Xlib.XDefaultRootWindow d
⍝ w←#.Xlib.XCreateSimpleWindow d r 0 0 200 100 0 0 0
⍝ #.Xlib.XSelectInput d w #.Xlib.StructureNotifyMask
⍝ #.Xlib.XMapWindow d w
⍝ {⍵≡#.Xlib.XNextEvent d: ⋄ ∇⍵} #.Xlib.MapNotify

⍝ Or:
⍝ d←#.Xlib.XOpenDisplay
⍝ r←#.Xlib.XDefaultRootWindow d
⍝ s←#.Xlib.XDefaultScreen 
⍝ f←#.GLX.glXChooseFBConfig d s 0
⍝ v←#.GLX.glXGetVisualFromFBConfig d (⊃f)

None←0

True←1
False←0

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

InputOutput←1
InputOnly←2

CWBackPixmap←2*0
CWBackPixel←2*1
CWBorderPixmap←2*2
CWBorderPixel←2*3
CWBitGravity←2*4
CWWinGravity←2*5
CWBackingStore←2*6
CWBackingPlanes←2*7
CWBackingPixel←2*8
CWOverrideRedirect←2*9
CWSaveUnder←2*10
CWEventMask←2*11
CWDontPropagate←2*12
CWColormap←2*13
CWCursor←2*14

AllocNone←0
AllocAll←1

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

∇ {z}←XCreateColormap x
 :If 3≠⎕NC'XCreateColormap_DLL'
     'XCreateColormap_DLL'⎕NA'P libX11.so|XCreateColormap P P P I4'
 :EndIf
 z←XCreateColormap_DLL x
∇

∇ {z}←XCreateWindow x
 :If 3≠⎕NC'XCreateWindow_DLL'
     'XCreateWindow_DLL'⎕NA'P libX11.so|XCreateWindow P P I4 I4 U4 U4 U4 I4 U4 P P <{P P P P I4 I4 I4 I4 P P I4 I4 P P I4 I4 P P}'
 :EndIf
 z←XCreateWindow_DLL (¯1↓x),⊂1 1 1 1 1 1 1 0 1 1 1 0 1 1 1 0 1 1\⊃⌽x
∇

∇ {z}←XCreateSimpleWindow x
 :If 3≠⎕NC'XCreateSimpleWindow_DLL'
     'XCreateSimpleWindow_DLL'⎕NA'P libX11.so|XCreateSimpleWindow P P I4 I4 U4 U4 U4 P P'
 :EndIf
 z←XCreateSimpleWindow_DLL x
∇

∇ XSelectInput x
 :If 3≠⎕NC'XSelectInput_DLL'
     'XSelectInput_DLL'⎕NA'I4 libX11.so|XSelectInput P P P'
 :EndIf
 {}XSelectInput_DLL x
∇

∇ XStoreName x
 :If 3≠⎕NC'XStoreName_DLL'
     'XStoreName_DLL'⎕NA'I4 libX11.so|XStoreName P P <0T1[]'
 :EndIf
 {}XStoreName_DLL x
∇

∇ XMapWindow x
 :If 3≠⎕NC'XMapWindow_DLL'
     'XMapWindow_DLL'⎕NA'I4 libX11.so|XMapWindow P P'
 :EndIf
 {}XMapWindow_DLL x
∇

∇ {z}←XNextEvent x
 :If 3≠⎕NC'XNextEvent_DLL'
     ⍝ P[24] ensures that this struct isn't smaller than struct XEvent.
     'XNextEvent_DLL'⎕NA'I4 libX11.so|XNextEvent P >{I4 P[24]}'
 :EndIf
 ⍝ Just return the event type for the nonce.
 z←⊃XNextEvent_DLL x 0
∇

∇ XFree x
 :If 3≠⎕NC'XFree_DLL'
     'XFree_DLL'⎕NA'I4 libX11.so|XFree P'
 :EndIf
 {}XFree_DLL x
∇

:EndNamespace
