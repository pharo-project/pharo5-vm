compile abstract instructions
genJumpMutable: sourceReg scratchReg: scratchReg
	<returnTypeC: #'AbstractInstruction *'>
	cogit MoveMw: 0 r: sourceReg R: scratchReg. 
	^ self genJumpBaseHeaderMutable: scratchReg