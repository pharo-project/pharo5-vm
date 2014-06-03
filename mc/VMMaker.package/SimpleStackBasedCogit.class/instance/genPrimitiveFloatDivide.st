primitive generators
genPrimitiveFloatDivide
	^self genDoubleArithmetic: DivRdRd preOpCheck: #genDoubleFailIfZeroArgRcvr:arg: