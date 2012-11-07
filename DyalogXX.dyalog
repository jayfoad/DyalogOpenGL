:Namespace DyalogXX

∇ r←GetDLLName;⎕IO
  ⎕IO←0
  r←⊃#.⎕WG'aplversion'
  r←(r⍳' ')↑r
  r←(r⍳'-')↓r
  :If r≡'-64'
      r←'dyalog64'
  :Else
      r←'dyalog32'
  :EndIf
∇

:EndNamespace
