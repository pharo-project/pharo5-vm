accessing-abstract
setRegisterState: aRegisterStateArray
	"N.B. keep in sync with voidRegisterState"

	self r0:  (aRegisterStateArray at: 1).
	self r1: (aRegisterStateArray at: 2).
	self r2: (aRegisterStateArray at: 3).
	self r3: (aRegisterStateArray at: 4).
	self r4: (aRegisterStateArray at: 5).
	self r5: (aRegisterStateArray at: 6).
	self r6: (aRegisterStateArray at: 7).
	self r7: (aRegisterStateArray at: 8).
	self r8: (aRegisterStateArray at: 9).
	self r9: (aRegisterStateArray at: 10).
	self r10: (aRegisterStateArray at: 11).
	self fp: (aRegisterStateArray at: 12).
	self r12: (aRegisterStateArray at: 13).
	self sp: (aRegisterStateArray at: 14).
	self lr: (aRegisterStateArray at: 15).
	self pc: (aRegisterStateArray at: 16).
	self eflags:  (aRegisterStateArray at: 17).