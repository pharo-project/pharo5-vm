primitive generators
genPrimitiveEqual
	^self 
		genSmallIntegerComparison: JumpZero
		orDoubleComparison: #JumpFPEqual:
		invert: false