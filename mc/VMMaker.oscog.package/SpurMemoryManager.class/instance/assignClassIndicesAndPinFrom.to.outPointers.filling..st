image segment in/out
assignClassIndicesAndPinFrom: segmentStart to: segmentLimit outPointers: outPointerArray filling: loadedObjectsArray
	"This is part of loadImageSegmentFrom:outPointers:.
	 Make a final pass, assigning the real class indices and/or pinning pinned objects."
	| fillIdx objOop |
	objOop := self objectStartingAt: segmentStart.
	fillIdx := 0.
	[objOop < segmentLimit] whileTrue:
		[| classRef classOop classIndex |
		 self storePointerUnchecked: fillIdx ofObject: loadedObjectsArray withValue: objOop.
		 fillIdx := fillIdx + 1.
		 "In the segment, class indices are offset indexes into the segment data,
		  or into outPointers.  See mapOopsFrom:to:outPointers:outHashes:."
		 classRef := (self classIndexOf: objOop) - self firstClassIndexPun.
		 classOop := (classRef anyMask: TopHashBit)
						ifTrue: [self fetchPointer: classRef - TopHashBit ofObject: outPointerArray]
						ifFalse: [classRef * self allocationUnit + segmentStart].
		 classIndex := self rawHashBitsOf: classOop.
		 self assert: (classIndex > self lastClassIndexPun
					  and: [(self classOrNilAtIndex: classIndex) = classOop]).
		 self setClassIndexOf: objOop to: classIndex.
		 ((self isInNewSpace: objOop)
		  and: [self isPinned: objOop]) ifTrue:
			[| oldClone |
			 oldClone := self cloneInOldSpaceForPinning: objOop.
			 oldClone ~= 0 ifTrue:
				[self setIsPinnedOf: oldClone to: true.
				 self forward: objOop to: oldClone]].
		 objOop := self objectAfter: objOop limit: segmentLimit].
