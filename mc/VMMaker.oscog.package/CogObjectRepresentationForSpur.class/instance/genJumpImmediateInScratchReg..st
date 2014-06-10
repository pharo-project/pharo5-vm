compile abstract instructions
genJumpImmediateInScratchReg: aRegister
	<returnTypeC: #'AbstractInstruction *'>
	cogit AndCq: objectMemory tagMask R: aRegister.
	^cogit JumpNonZero: 0