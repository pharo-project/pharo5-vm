primitive generators
genPrimitiveLessOrEqual
	^self
		genSmallIntegerComparison: JumpLessOrEqual
		orDoubleComparison: #JumpFPGreaterOrEqual:
		invert: true