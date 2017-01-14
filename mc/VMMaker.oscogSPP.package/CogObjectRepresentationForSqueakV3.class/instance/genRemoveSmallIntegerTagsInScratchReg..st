compile abstract instructions
genRemoveSmallIntegerTagsInScratchReg: scratchReg 
	cogit SubCq: 1 R: scratchReg.
	^0