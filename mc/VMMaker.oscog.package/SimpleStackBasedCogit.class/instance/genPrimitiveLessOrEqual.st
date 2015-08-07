primitive generators
genPrimitiveLessOrEqual
	^self
		genSmallIntegerComparison: JumpLessOrEqual
		orDoubleComparison: #JumpFPGreater:
		invert: true