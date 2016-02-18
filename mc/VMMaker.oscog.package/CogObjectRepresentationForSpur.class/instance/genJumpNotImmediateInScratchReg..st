compile abstract instructions
genJumpNotImmediateInScratchReg: aRegister
	<returnTypeC: #'AbstractInstruction *'>
	cogit AndCq: objectMemory tagMask R: aRegister.
	^cogit JumpZero: 0