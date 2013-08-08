instance creation
newForCallbackArgs
	"Answer an Alien suitable for wrapping the stack pointer of a callback, hence
	 providing access to its args.  The actual stack pointer is slammed in in
	 Callback>>valueWithStackPointer: prior to each evaluation of the callback block"
	^(self basicNew: self sizeofLong + self sizeofPointer)
		sizeFieldPut: self dataSize negated;
		yourself