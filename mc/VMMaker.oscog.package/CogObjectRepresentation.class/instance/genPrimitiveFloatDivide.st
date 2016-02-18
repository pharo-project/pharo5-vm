primitive generators
genPrimitiveFloatDivide
	<option: #DPFPReg0>
	^self 
		genDoubleArithmetic: DivRdRd
		preOpCheck: #genDoubleFailIfZeroArgRcvr:arg: