instantiation
maxSlotsForAlloc
	"Answer the maximum number of slots we are willing to attempt to allocate in an object.
	 Must fit in 32-bits; c.f. bytesInObject:. Chosen so that maxSlotsForAlloc * self bytesPerWord is +ve."
	^512*1024*1024-1