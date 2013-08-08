abi
genPassConst: constant asArgument: zeroRelativeArgIndex
	zeroRelativeArgIndex caseOf: {
		[0] -> [cogit MoveCq: constant R: CArg0Reg].
		[1] -> [cogit MoveCq: constant R: CArg1Reg].
		[2] -> [cogit MoveCq: constant R: CArg2Reg].
		[3] -> [cogit MoveCq: constant R: CArg3Reg].}.
	^0