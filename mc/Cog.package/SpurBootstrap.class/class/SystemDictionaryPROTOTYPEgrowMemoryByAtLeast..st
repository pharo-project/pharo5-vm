method prototypes
SystemDictionaryPROTOTYPEgrowMemoryByAtLeast: numBytes
	"Grow memory by at least the requested number of bytes.
	 Primitive.  Fail if no memory is available.  Essential."
	<primitive: 180>
	^(numBytes isInteger and: [numBytes > 0])
		ifTrue: [OutOfMemory signal]
		ifFalse: [self primitiveFailed]