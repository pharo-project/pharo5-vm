image segment in/out
mapOopsFrom: segStart to: segAddr outPointers: outPointerArray outHashes: savedOutHashes
	"This is part of storeImageSegmentInto:outPointers:roots:.
	 Now scan, adding out pointers to the outPointersArray; all objects in arrayOfObjects
	 have had their hashes set to point to their copies in segmentWordArray.  Answer the
	 outIndex if the scan succeded.  Fail if outPointers is too small and answer -1."
	| objOop outIndex |
	outIndex := 0.
	self fillObj: outPointerArray numSlots: (self numSlotsOf: outPointerArray) with: nilObj.
	objOop := self objectStartingAt: segStart.
	[objOop < segAddr] whileTrue:
		[| oop segIndex |
		 oop := self fetchClassOfNonImm: objOop.
		 (self isMarked: oop) ifFalse: "oop is a new outPointer; allocate its oop"
			[outIndex := self newOutPointer: oop at: outIndex in: outPointerArray hashes: savedOutHashes.
			 outIndex = 0 ifTrue:"no room in outPointers; fail"
				[^-1]].
		 "Set the clone's class index to an offset index into segmentWordArray.
		  Use an offset so that code cannot confuse a clone with e.g. a forwarder."
		 segIndex := self rawHashBitsOf: oop.
		 self setClassIndexOf: objOop to: segIndex + self firstClassIndexPun.
		 0 to: (self numPointerSlotsOf: objOop) - 1 do:
			[:i|
			 oop := self fetchPointer: i ofObject: objOop.
			 (self isNonImmediate: oop) ifTrue:
				[(self isMarked: oop) ifFalse: "oop is a new outPointer; allocate its oop"
					[outIndex := self newOutPointer: oop at: outIndex in: outPointerArray hashes: savedOutHashes.
					 outIndex = 0 ifTrue: "no room in outPointers; fail"
						[^-1]].
				 oop := self mappedInSegmentOopOf: oop.
				 self storePointerUnchecked: i ofObject: objOop withValue: oop]].
		 objOop := self objectAfter: objOop limit: segAddr].
	^outIndex