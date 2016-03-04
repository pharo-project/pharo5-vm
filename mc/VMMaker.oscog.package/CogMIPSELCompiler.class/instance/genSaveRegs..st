abi
genSaveRegs: regMask
	"Save the registers in regMask for a call into the C run-time from a trampoline.
	 We don't need to do anything because all of the abstract registers are
	 allocated to C preserved registers.  But for the future..."
	self assert: regMask = 0.
	self deny: (regMask anyMask: (cogit registerMaskFor: SP and: FP and: RA)).
	R28 to: R0 by: -1 do:
		[:reg|
		 (regMask anyMask: (cogit registerMaskFor: reg)) ifTrue:
			[cogit PushR: reg]].
	^0