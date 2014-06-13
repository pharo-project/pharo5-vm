free space
isValidFreeObject: objOop
	| chunk |
	^(self addressCouldBeOldObj: objOop)
	  and: [(self isFreeObject: objOop)
	  and: [(self oop: (self addressAfter: objOop) isLessThanOrEqualTo: endOfMemory)
	  and: [((chunk := (self fetchPointer: self freeChunkNextIndex ofFreeChunk: objOop)) = 0
		   or: [self isFreeObject: chunk])
	  and: [(self bytesInObject: objOop) < (self numFreeLists * self allocationUnit)
		    or: [((chunk := (self fetchPointer: self freeChunkParentIndex ofFreeChunk: objOop)) = 0
			   or: [self isFreeObject: chunk])
			  and: [((chunk := (self fetchPointer: self freeChunkSmallerIndex ofFreeChunk: objOop)) = 0
				    or: [self isFreeObject: chunk])
			  and: [(chunk := (self fetchPointer: self freeChunkLargerIndex ofFreeChunk: objOop)) = 0
				    or: [self isFreeObject: chunk]]]]]]]]