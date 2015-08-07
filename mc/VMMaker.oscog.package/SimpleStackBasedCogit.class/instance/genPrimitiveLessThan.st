primitive generators
genPrimitiveLessThan
	^self
		genSmallIntegerComparison: JumpLess
		orDoubleComparison: #JumpFPGreaterOrEqual:
		invert: true