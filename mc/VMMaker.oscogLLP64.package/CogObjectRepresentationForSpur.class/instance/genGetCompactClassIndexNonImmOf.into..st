compile abstract instructions
genGetCompactClassIndexNonImmOf: instReg into: destReg
	"Fetch the instance's class index into destReg."
	^self genGetClassIndexOfNonImm: instReg into: destReg