primitive generators
genPrimitiveNotEqual
	^self genSmallIntegerComparison: JumpNonZero orDoubleComparison: #JumpFPNotEqual: asSymbol