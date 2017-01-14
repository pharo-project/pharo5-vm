abi
genSaveRegs: regMask
	"Save the registers in regMask for a call into the C run-time from a trampoline."

	self assert: (EDI > EAX and: [EDI - EAX + 1 = 8]).
	self deny: (regMask anyMask: (cogit registerMaskFor: ESP and: EBP)).
	EDI to: EAX by: -1 do:
		[:reg|
		 (regMask anyMask: (cogit registerMaskFor: reg)) ifTrue:
			[cogit PushR: reg]].
	^0