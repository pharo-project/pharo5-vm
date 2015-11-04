compile abstract instructions
genJumpNotSmallFloatInScratchReg: aRegister
	^self genJumpNotSmallFloat: aRegister scratchReg: TempReg