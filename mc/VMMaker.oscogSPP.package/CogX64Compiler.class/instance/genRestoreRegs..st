abi
genRestoreRegs: regMask
	"Restore the registers in regMask as saved by genSaveRegs:."
	self deny: (regMask anyMask: (cogit registerMaskFor: RSP and: RBP)).
	RAX to: R15 do:
		[:reg|
		 (regMask anyMask: (cogit registerMaskFor: reg)) ifTrue:
			[cogit PopR: reg]].
	^0