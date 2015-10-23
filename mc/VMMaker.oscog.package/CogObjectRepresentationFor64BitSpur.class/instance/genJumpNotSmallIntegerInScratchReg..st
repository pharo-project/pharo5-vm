compile abstract instructions
genJumpNotSmallIntegerInScratchReg: aRegister
	^self genJumpNotSmallInteger: aRegister scratchReg: TempReg