compile abstract instructions
genJumpSmallIntegerInScratchReg: aRegister
	<returnTypeC: #'AbstractInstruction *'>
	cogit AndCq: 1 R: aRegister.
	^cogit JumpNonZero: 0