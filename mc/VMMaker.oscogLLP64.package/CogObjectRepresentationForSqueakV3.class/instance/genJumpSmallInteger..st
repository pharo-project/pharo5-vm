compile abstract instructions
genJumpSmallInteger: aRegister
	<returnTypeC: #'AbstractInstruction *'>
	cogit TstCq: 1 R: aRegister.
	^cogit JumpNonZero: 0