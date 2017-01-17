compile abstract instructions
genGetClassTagOf: instReg into: destReg scratchReg: scratchReg
	^self genGetInlineCacheClassTagFrom: instReg into: destReg forEntry: true