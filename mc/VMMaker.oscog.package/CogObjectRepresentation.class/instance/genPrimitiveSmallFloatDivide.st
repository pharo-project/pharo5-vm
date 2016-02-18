primitive generators
genPrimitiveSmallFloatDivide
	<option: #Spur64BitMemoryManager>
	^self genSmallFloatArithmetic: DivRdRd preOpCheck: #genDoubleFailIfZeroArgRcvr:arg: