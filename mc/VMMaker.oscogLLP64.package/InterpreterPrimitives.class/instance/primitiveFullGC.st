memory space primitives
primitiveFullGC
	"Do a full garbage collection.  In SqueakV3ObjectMemory, answer the number
	 of bytes available (including swap space if dynamic memory management is
	 supported).  In Spur, answer the size of the largest free chunk."

	objectMemory hasSpurMemoryManagerAPI ifTrue:
		[self pop: 1 thenPushInteger: objectMemory fullGC.
		 ^self].
	objectMemory fullGCLock > 0 ifTrue:
		[self primitiveFailFor: PrimErrInappropriate.
		 ^self].
	objectMemory incrementalGC.  "maximimize space for forwarding table"
	objectMemory fullGC.
	self pop: 1 thenPushInteger: (objectMemory bytesLeft: true)