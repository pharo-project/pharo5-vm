image segment in/out
assignClassIndicesAndPinFrom: segmentStart to: segmentLimit outPointers: outPointerArray
	"Make a final pass, assigning class indices and/or pinning pinned objects"
	| objOop topHashBit |
	topHashBit := 1 bitShift: self identityHashFieldWidth - 1.
	objOop := self objectStartingAt: segmentStart.
	[objOop < segmentLimit] whileTrue:
		[| classRef classOop classIndex |
		 classRef := self classIndexOf: objOop.
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
