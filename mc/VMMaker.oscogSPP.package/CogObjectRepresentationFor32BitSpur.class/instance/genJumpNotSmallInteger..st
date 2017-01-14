compile abstract instructions
genJumpNotSmallInteger: aRegister
	<returnTypeC: #'AbstractInstruction *'>
	cogit TstCq: 1 R: aRegister.
	^cogit JumpZero: 0