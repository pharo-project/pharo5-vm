memory space primitives
primitiveFullGC
	"Do a full garbage collection and return the number of bytes available (including swap space if dynamic memory management is supported)."

	objectMemory fullGCLock > 0 ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	self externalWriteBackHeadFramePointers.
	objectMemory incrementalGC.  "maximimize space for forwarding table"
	objectMemory fullGC.
	self pop: 1 thenPushInteger: (objectMemory bytesLeft: true).