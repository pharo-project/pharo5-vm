abi
genSaveRegs: regMask
	"Save the registers in regMask for a call into the C run-time from a trampoline."

	self assert: (R15 > RAX and: [R15 - RAX + 1 = 16]).
	self deny: (regMask anyMask: (cogit registerMaskFor: RSP and: RBP)).
	R15 to: RAX by: -1 do:
		[:reg|
		 (regMask anyMask: (cogit registerMaskFor: reg)) ifTrue:
			[cogit PushR: reg]].
	^0