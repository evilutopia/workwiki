; Use d as modifier, map keys outside main keyboard area into main keyboard area.

SetCapsLockState, AlwaysOff

; d + hjkl (left, down, up, right)
d & h::SendInput {Blind}{Left}
d & j::SendInput {Blind}{Down}
d & k::SendInput {Blind}{Up}
d & l::SendInput {Blind}{Right}

; Move the Ins/Home/PgUp and Del/End/PgDn to 2x3 keys near the arrows 
d & p::SendInput {Blind}{Insert}
d & [::SendInput {Blind}{Home}
d & ]::SendInput {Blind}{PgUp}
d & `;::SendInput {Blind}{Delete}
d & '::SendInput {Blind}{End}
d & Enter::SendInput {Blind}{PgDn}

; PrtSc/ScrLk/Pause is above the arrows
d & u::SendInput {Blind}{PrintScreen}
d & i::SendInput {Blind}{ScrollLock}
d & o::SendInput {Blind}{Pause}

; Number row
CapsLock::send, {Esc}
;CapsLock & `::SendInput {Blind}{Esc}
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


d::Send, {d}

