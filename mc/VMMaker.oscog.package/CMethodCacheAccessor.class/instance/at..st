accessing
at: index
	"The special handling of functionPointerIndex is necessary because in simulation function
	 pointers are Smalltalk symbols (under simulation primitive dispatch is done via perform:)."
	index - 1 \\ entrySize = functionPointerIndex ifTrue:
		[^methodCacheArray at: index].
	^objectMemory longAt: index * elementByteSize + address