compile abstract instructions
genJumpSmallIntegerInScratchReg: aRegister
	^self genJumpSmallInteger: aRegister scratchReg: TempReg