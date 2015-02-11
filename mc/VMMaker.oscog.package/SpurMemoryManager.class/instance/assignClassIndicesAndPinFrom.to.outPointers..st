image segment in/out
assignClassIndicesAndPinFrom: segmentStart to: segmentLimit outPointers: outPointerArray
	"This is part of loadImageSegmentFrom:outPointers:.
	 Make a final pass, assigning the real class indices and/or pinning pinned objects."
	| objOop topHashBit |
	topHashBit := 1 << (self identityHashFieldWidth - 1).
	objOop := self objectStartingAt: segmentStart.
	[objOop < segmentLimit] whileTrue:
		[| classRef classOop classIndex |
		 "In the segment, class indices are offset indexes into the segment data,
		  or into outPointers.  See mapOopsFrom:to:outPointers:outHashes:."
		 classRef := (self classIndexOf: objOop) - self firstClassIndexPun.
		 classOop := (classRef anyMask: topHashBit)
						ifTrue: [self fetchPointer: classRef - topHashBit ofObject: outPointerArray]
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
