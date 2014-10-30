image segment in/out
mapOopsFrom: segStart to: segAddr outPointers: outPointerArray outHashes: savedOutHashes
	"Now scan, adding out pointers to the outPointersArray; all objects in arrayOfObjects
	 have their hashes set to point to their copies in segmentWordArray.  Answer the outIndex
	 if the scan succeded, otherwise answer -1.  It will fail if outPointers is too small."
	| objOop outIndex topHashBit topOopBit |
	outIndex := 0.
	self fillObj: outPointerArray numSlots: (self numSlotsOf: outPointerArray) with: nilObj.
	topHashBit := 1 bitShift: self identityHashFieldWidth - 1.
	topOopBit := 1 bitShift: self bytesPerOop * 8 - 1.
	objOop := self objectStartingAt: segStart.
	[objOop < segAddr] whileTrue:
		[| oop hash |
		 oop := self fetchClassOfNonImm: objOop.
		 (self isMarked: oop) ifFalse: "oop is a new outPointer; allocate its oop"
			[outIndex := self newOutPointer: oop at: outIndex in: outPointerArray hashes: savedOutHashes topHashBit: topHashBit.
			 outIndex = 0 ifTrue:"no room in outPointers; fail"
				[^-1]].
		 hash := self rawHashBitsOf: oop.
		 self setClassIndexOf: objOop to: hash.
		 0 to: (self numPointerSlotsOf: objOop) - 1 do:
			[:i|
			 oop := self fetchPointer: i ofObject: objOop.
			 (self isNonImmediate: oop) ifTrue:
				[(self isMarked: oop) ifFalse: "oop is a new outPointer; allocate its oop"
					[outIndex := self newOutPointer: oop at: outIndex in: outPointerArray hashes: savedOutHashes topHashBit: topHashBit.
					 outIndex = 0 ifTrue: "no room in outPointers; fail"
						[^-1]].
				 oop := self mappedOopOf: oop topHashBit: topHashBit topOopBit: topOopBit..
				 self storePointerUnchecked: i ofObject: objOop withValue: oop]].
		 objOop := self objectAfter: objOop limit: segAddr].
	^outIndex