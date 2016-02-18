abi
genRestoreRegsExcept: preservedReg
	self assert: (R15 > RAX and: [R15 - RAX + 1 = 16]).
	RAX to: R15 do:
		[:reg|
		(reg between: RSP and: RBP) ifFalse:
			[preservedReg = reg
				ifTrue: [cogit AddCq: 8 R: RSP]
				ifFalse: [cogit PopR: reg]]].
	^0