instantiation
maxSlotsForAlloc
	"Answer the maximum number of slots we are willing to attempt to allocate in an object.
	 Must fit in 32-bits; c.f. bytesInObject:"
	^self subclassResponsibility