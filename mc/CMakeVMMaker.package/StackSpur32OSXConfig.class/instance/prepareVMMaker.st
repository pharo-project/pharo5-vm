source generation
prepareVMMaker
	| maker |
	maker := super prepareVMMaker.
	maker options: #(ObjectMemory Spur32BitMemoryManager).
	^ maker