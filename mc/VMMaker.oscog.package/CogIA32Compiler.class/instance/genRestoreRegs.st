abi
genRestoreRegs
	EAX to: EDI do:
		[:reg|
		 (reg between: ESP and: EBP) ifFalse:
			[cogit PopR: reg]].
	^0