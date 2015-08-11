primitive generators
genPrimitiveLessThan
	^self
		genSmallIntegerComparison: JumpLess
		orDoubleComparison: #JumpFPGreater:
		invert: true