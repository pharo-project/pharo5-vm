gc -- compaction
isObjectForwarded: oop 
	"Answer if the given object has a forwarding table entry 
	 during a compaction or become operation."
	^(self isNonIntegerObject: oop) and: [self isMarked: oop]