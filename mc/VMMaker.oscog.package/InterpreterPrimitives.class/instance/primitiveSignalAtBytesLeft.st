memory space primitives
primitiveSignalAtBytesLeft
	"Set the low-water mark for free space. When the free space falls
	 below this level, the new and new: primitives fail and system attempts
	 to allocate space (e.g., to create a method context) cause the low-space
	 semaphore (if one is registered) to be signalled."
	| bytes |
	bytes := self stackTop.
	((objectMemory isIntegerObject: bytes)
	 and: [(bytes := objectMemory integerValueOf: bytes) >= 0])
		ifTrue: [objectMemory lowSpaceThreshold: bytes. self pop: 1]
		ifFalse: [self primitiveFailFor: PrimErrBadArgument]