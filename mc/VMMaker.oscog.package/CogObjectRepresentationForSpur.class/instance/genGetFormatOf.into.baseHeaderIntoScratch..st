compile abstract instructions
genGetFormatOf: sourceReg into: destReg baseHeaderIntoScratch: scratchReg
	self genGetBits: objectMemory formatMask ofFormatByteOf: sourceReg into: destReg baseHeaderIntoScratch: scratchReg.
	^0