primitive generators
genPrimitiveGreaterOrEqual
	^self 
		genSmallIntegerComparison: JumpGreaterOrEqual
		orDoubleComparison: #JumpFPGreaterOrEqual:
		invert: false