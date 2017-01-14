free space
isValidFreeObject: objOop
	| chunk |
	^(self addressCouldBeOldObj: objOop)
	  and: [(self isFreeObject: objOop)
	  and: [(self oop: (self addressAfter: objOop) isLessThanOrEqualTo: endOfMemory)
	  and: [((chunk := (self fetchPointer: self freeChunkNextIndex ofFreeChunk: objOop)) = 0
		   or: [self isFreeOop: chunk])
	  and: [(self isLargeFreeObject: objOop) not
		    or: [((chunk := (self fetchPointer: self freeChunkParentIndex ofFreeChunk: objOop)) = 0
			   or: [(self isFreeOop: chunk) and: [self isLargeFreeObject: chunk]])
			  and: [((chunk := (self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: objOop)) = 0
				    or: [(self isFreeOop: chunk) and: [self isLargeFreeObject: chunk]])
			  and: [(chunk := (self fetchPointer: self freeChunkLargerIndex ofFreeChunk: objOop)) = 0
				    or: [(self isFreeOop: chunk) and: [self isLargeFreeObject: chunk]]]]]]]]]