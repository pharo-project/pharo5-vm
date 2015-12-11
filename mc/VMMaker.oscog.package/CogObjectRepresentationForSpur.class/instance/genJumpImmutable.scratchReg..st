compile abstract instructions
genJumpImmutable: sourceReg scratchReg: scratchReg
	<returnTypeC: #'AbstractInstruction *'>
	cogit MoveMw: 0 r: sourceReg R: scratchReg. 
	^ self genJumpBaseHeaderImmutable: scratchReg