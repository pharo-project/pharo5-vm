compile abstract instructions
genJumpNotImmediate: aRegister
	<returnTypeC: #'AbstractInstruction *'>
	cogit TstCq: objectMemory tagMask R: aRegister.
	^cogit JumpZero: 0