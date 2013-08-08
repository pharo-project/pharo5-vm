abi
genPassReg: abstractRegister asArgument: zeroRelativeArgIndex
	zeroRelativeArgIndex caseOf: {
		[0] -> [cogit MoveR: abstractRegister R: CArg0Reg].
		[1] -> [cogit MoveR: abstractRegister R: CArg1Reg].
		[2] -> [cogit MoveR: abstractRegister R: CArg2Reg].
		[3] -> [cogit MoveR: abstractRegister R: CArg3Reg].}.
	^0