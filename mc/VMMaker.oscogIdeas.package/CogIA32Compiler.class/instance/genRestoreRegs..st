abi
genRestoreRegs: regMask
	"Restore the registers in regMask as saved by genSaveRegs:."
	self deny: (regMask anyMask: (cogit registerMaskFor: ESP and: EBP)).
	EAX to: EDI do:
		[:reg|
		 (regMask anyMask: (cogit registerMaskFor: reg)) ifTrue:
			[cogit PopR: reg]].
	^0