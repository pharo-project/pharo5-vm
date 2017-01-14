instantiation
maxSlotsForAlloc
	"Answer the maximum number of slots we are willing to attempt to allocate in an object.
	 Must fit in 56-bits; c.f. bytesInObject:"
	^1024*1024*1024*1024