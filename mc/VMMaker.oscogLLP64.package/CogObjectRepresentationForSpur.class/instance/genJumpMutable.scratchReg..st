compile abstract instructions
genJumpMutable: sourceReg scratchReg: scratchReg
	<returnTypeC: #'AbstractInstruction *'>
	<option: #IMMUTABILITY>
	cogit MoveMw: 0 r: sourceReg R: scratchReg. 
	^ self genJumpBaseHeaderMutable: scratchReg