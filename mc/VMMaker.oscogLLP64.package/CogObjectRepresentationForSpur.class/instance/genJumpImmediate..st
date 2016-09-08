compile abstract instructions
genJumpImmediate: aRegister
	<returnTypeC: #'AbstractInstruction *'>
	cogit TstCq: objectMemory tagMask R: aRegister.
	^cogit JumpNonZero: 0