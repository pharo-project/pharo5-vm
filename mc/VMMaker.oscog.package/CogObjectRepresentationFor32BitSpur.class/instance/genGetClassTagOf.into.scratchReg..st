compile abstract instructions
genGetClassTagOf: instReg into: destReg scratchReg: scratchReg
	^self getInlineCacheClassTagFrom: instReg into: destReg