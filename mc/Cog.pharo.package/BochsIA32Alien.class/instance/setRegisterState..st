accessing-abstract
setRegisterState: aRegisterStateArray
	"N.B. keep in sync with voidRegisterState"
	self eax: (aRegisterStateArray at: 1).
	self ebx: (aRegisterStateArray at: 2).
	self ecx: (aRegisterStateArray at: 3).
	self edx: (aRegisterStateArray at: 4).
	self esp: (aRegisterStateArray at: 5).
	self ebp: (aRegisterStateArray at: 6).
	self esi: (aRegisterStateArray at: 7).
	self edi: (aRegisterStateArray at: 8).
	self eip: (aRegisterStateArray at: 9).
	self eflags: (aRegisterStateArray at: 10).
	self xmm0low: (aRegisterStateArray at: 11).
	self xmm1low: (aRegisterStateArray at: 12).
	self xmm2low: (aRegisterStateArray at: 13).
	self xmm3low: (aRegisterStateArray at: 14).
	self xmm4low: (aRegisterStateArray at: 15).
	self xmm5low: (aRegisterStateArray at: 16).
	self xmm6low: (aRegisterStateArray at: 17).
	self xmm7low: (aRegisterStateArray at: 18)