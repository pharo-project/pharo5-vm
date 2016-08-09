source generation
prepareVMMaker
	| maker |
	maker := super prepareVMMaker.
	maker options: #(
		ObjectMemory Spur64BitCoMemoryManager
		FailImbalancedPrimitives false
		ISA X64).
	^ maker