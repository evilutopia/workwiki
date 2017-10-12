; Use CapsLock as modifier, map keys outside main keyboard area into main keyboard area.

SetCapsLockState, AlwaysOff

; Capslock + hjkl (left, down, up, right)
CapsLock & h::SendInput {Blind}{Left}
CapsLock & j::SendInput {Blind}{Down}
CapsLock & k::SendInput {Blind}{Up}
CapsLock & l::SendInput {Blind}{Right}

; Move the Ins/Home/PgUp and Del/End/PgDn to 2x3 keys near the arrows 
CapsLock & p::SendInput {Blind}{Insert}
CapsLock & [::SendInput {Blind}{Home}
CapsLock & ]::SendInput {Blind}{PgUp}
CapsLock & `;::SendInput {Blind}{Delete}
CapsLock & '::SendInput {Blind}{End}
CapsLock & Enter::SendInput {Blind}{PgDn}

; PrtSc/ScrLk/Pause is above the arrows
CapsLock & u::SendInput {Blind}{PrintScreen}
CapsLock & i::SendInput {Blind}{ScrollLock}
CapsLock & o::SendInput {Blind}{Pause}

; Number row
CapsLock & `::SendInput {Blind}{Esc}
CapsLock & 1::SendInput {Blind}{F1}
CapsLock & 2::SendInput {Blind}{F2}
CapsLock & 3::SendInput {Blind}{F3}
CapsLock & 4::SendInput {Blind}{F4}
CapsLock & 5::SendInput {Blind}{F5}
CapsLock & 6::SendInput {Blind}{F6}
CapsLock & 7::SendInput {Blind}{F7}
CapsLock & 8::SendInput {Blind}{F8}
CapsLock & 9::SendInput {Blind}{F9}
CapsLock & 0::SendInput {Blind}{F10}
CapsLock & -::SendInput {Blind}{F11}
CapsLock & =::SendInput {Blind}{F12}
