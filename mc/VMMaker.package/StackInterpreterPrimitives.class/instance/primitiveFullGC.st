memory space primitives
primitiveFullGC
	"Do a full garbage collection.  In SqueakV3ObjectMemory, answer the number
	 of bytes available (including swap space if dynamic memory management is
	 supported).  In Spur, answer the size of the largest free chunk."

	self externalWriteBackHeadFramePointers.
	super primitiveFullGC