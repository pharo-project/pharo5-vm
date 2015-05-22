source generation
prepareVMMaker
	| maker |
	maker := super prepareVMMaker.
	maker options: #(
		ObjectMemory Spur32BitMemoryManager
		FailImbalancedPrimitives false
		ISA IA32).
	^ maker