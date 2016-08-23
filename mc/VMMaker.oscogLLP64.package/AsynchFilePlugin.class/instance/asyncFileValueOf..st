primitives
asyncFileValueOf: oop
	"Answer a pointer to the first byte of the async file record within the given
	 Smalltalk bytes object, or fail and answer nil if oop is not an async file record."

	<returnTypeC: 'AsyncFile *'>
	((interpreterProxy isBytes: oop)
	 and: [(interpreterProxy byteSizeOf: oop) = (self sizeof: #AsyncFile)]) ifTrue:
		[^self cCoerceSimple: (interpreterProxy firstIndexableField: oop) to: 'AsyncFile *'].
	interpreterProxy primitiveFailFor: PrimErrBadArgument.
	^nil