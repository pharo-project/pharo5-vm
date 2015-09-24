abi
genPassConst: constant asArgument: zeroRelativeArgIndex
	zeroRelativeArgIndex caseOf: {
		[0] -> [cogit MoveCq: constant R: RDI].
		[1] -> [cogit MoveCq: constant R: RSI].
		[2] -> [cogit MoveCq: constant R: RDX].
		[3] -> [cogit MoveCq: constant R: RCX].}.
	^0