compile abstract instructions
genJumpNotSmallIntegerInScratchReg: aRegister
	<returnTypeC: #'AbstractInstruction *'>
	cogit AndCq: 1 R: aRegister.
	^cogit JumpZero: 0