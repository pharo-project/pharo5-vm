abi
genPassReg: abstractRegister asArgument: zeroRelativeArgIndex
	zeroRelativeArgIndex caseOf: {
		[0] -> [cogit MoveR: abstractRegister R: RDI].
		[1] -> [cogit MoveR: abstractRegister R: RSI].
		[2] -> [cogit MoveR: abstractRegister R: RDX].
		[3] -> [cogit MoveR: abstractRegister R: RCX].}.
	^0