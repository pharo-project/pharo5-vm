abi
genRestoreRegs: regMask
	"Restore the registers in regMask as saved by genSaveRegs:.
	 We don't need to do anything because all of the abstract registers are
	 allocated to C preserved registers.  But for the future..."
	self assert: regMask = 0.
	self deny: (regMask anyMask: (cogit registerMaskFor: SP and: FP and: RA)).
	R0 to: R28 do:
		[:reg|
		 (regMask anyMask: (cogit registerMaskFor: reg)) ifTrue:
			[cogit PopR: reg]].
	^0