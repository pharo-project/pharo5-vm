compile abstract instructions
genGetClassTagOf: instReg into: destReg scratchReg: scratchReg
	"Compatibility with SpurObjectRepresentation/purMemorymanager."
	^self genGetClassObjectOf: instReg into: destReg scratchReg: scratchReg