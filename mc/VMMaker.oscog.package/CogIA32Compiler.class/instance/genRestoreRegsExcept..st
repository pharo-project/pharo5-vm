abi
genRestoreRegsExcept: abstractReg
	| realReg |
	realReg := self concreteRegister: abstractReg.
	realReg == EAX ifTrue: [cogit AddCq: 4 R: ESP] ifFalse: [cogit PopR: EAX].
	realReg == EBX ifTrue: [cogit AddCq: 4 R: ESP] ifFalse: [cogit PopR: EBX].
	realReg == ECX ifTrue: [cogit AddCq: 4 R: ESP] ifFalse: [cogit PopR: ECX].
	realReg == EDX ifTrue: [cogit AddCq: 4 R: ESP] ifFalse: [cogit PopR: EDX].
	realReg == ESI   ifTrue: [cogit AddCq: 4 R: ESP] ifFalse: [cogit PopR: ESI].
	realReg == EDI   ifTrue: [cogit AddCq: 4 R: ESP] ifFalse: [cogit PopR: EDI].
	^0