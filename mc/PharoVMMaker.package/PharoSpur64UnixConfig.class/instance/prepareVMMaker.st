source generation
prepareVMMaker
	| maker |
	maker := super prepareVMMaker.
	maker options: #(
		ObjectMemory Spur64BitCoMemoryManager
		ISA X64).
	^ maker