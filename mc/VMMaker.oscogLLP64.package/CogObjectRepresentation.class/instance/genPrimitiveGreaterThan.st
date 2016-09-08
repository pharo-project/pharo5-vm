primitive generators
genPrimitiveGreaterThan
	^self
		genSmallIntegerComparison: JumpGreater
		orDoubleComparison: #JumpFPGreater:
		invert: false