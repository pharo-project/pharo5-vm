abi
genRestoreRegsExcept: abstractReg
	| realReg |
	realReg := self concreteRegister: abstractReg.
	self assert: (R15 > RAX and: [R15 - RAX + 1 = 16]).
	RAX to: R15 do:
		[:reg|
		realReg = reg ifTrue: [cogit AddCq: 4 R: RSP] ifFalse: [cogit PopR: reg]].
	^0