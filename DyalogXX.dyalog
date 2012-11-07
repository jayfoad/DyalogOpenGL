:Namespace DyalogXX

∇ r←GetDLLName;⎕IO
  ⎕IO←0
  t←⊃#.⎕WG'aplversion'
  :If 'Windows'≡7↑t
      r←''
  :Else
      r←'.so'
  :Endif
  t←(t⍳' ')↑t
  t←(t⍳'-')↓t
  :If t≡'-64'
      r←'dyalog64',r
  :Else
      r←'dyalog32',r
  :EndIf
∇

:EndNamespace
