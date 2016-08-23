abi
genRestoreRegsExcept: preservedReg
	self assert: (EDI > EAX and: [EDI - EAX + 1 = 6]).
	EAX to: EDI do:
		[:reg|
		(reg between: ESP and: EBP) ifFalse:
			[preservedReg = reg
				ifTrue: [cogit AddCq: 4 R: ESP]
				ifFalse: [cogit PopR: reg]]].
	^0