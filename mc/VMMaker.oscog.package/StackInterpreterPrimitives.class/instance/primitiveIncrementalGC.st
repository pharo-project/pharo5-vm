memory space primitives
primitiveIncrementalGC
	"Do a quick, incremental garbage collection and return the number of bytes immediately available.
	 (Note: more space may be made available by doing a full garbage collection."

	self externalWriteBackHeadFramePointers.
	super primitiveIncrementalGC