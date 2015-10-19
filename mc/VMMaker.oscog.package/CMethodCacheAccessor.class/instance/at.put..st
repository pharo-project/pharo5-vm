accessing
at: index put: value
	"The special handling of functionPointerIndex is necessary because in simulation function
	 pointers are Smalltalk symbols (under simulation primitive dispatch is done via perform:)."
	(index = 16r44F and: [value = 16r1D]) ifTrue:
		[self halt].
	index - 1 \\ entrySize = functionPointerIndex ifTrue:
		[objectMemory longAt: index * elementByteSize + address put: (0 = value ifTrue: [value] ifFalse: [value identityHash]).
		 ^methodCacheArray at: index put: value].
	^objectMemory longAt: index * elementByteSize + address put: value