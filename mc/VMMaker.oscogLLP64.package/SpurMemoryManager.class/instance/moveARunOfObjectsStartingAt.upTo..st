compaction
moveARunOfObjectsStartingAt: startAddress upTo: limit 
	"Move the sequence of movable objects starting at startAddress.  Answer the start
	 of the next sequence of movable objects after a possible run of unmovable objects,
	 or the limit, if there are no more movable objects, or 0 if no more compaction can be
	 done. Compaction is done when the search through the freeList has reached the
	 address from which objects are being moved from.

	 There are two broad cases to be dealt with here.  One is a run of smallish objects
	 that can easily be moved into free chunks.  The other is a large object that is unlikely
	 to fit in the typical free chunk. This second pig needs careful handling; it needs to be
	 moved to the lowest place it will fit and not cause the scan to skip lots of smaller
	 free chunks looking in vain for somewhere to put it."
	<var: #startAddress type: #usqInt>
	<var: #limit type: #usqInt>
	<inline: false>
	| here hereObj hereObjHeader prevPrevFreeChunk prevFreeChunk thisFreeChunk maxFreeChunk |
	<var: #here type: #usqInt>
	<var: #there type: #usqInt>
	<var: #nextFree type: #usqInt>
	<var: #endOfFree type: #usqInt>
	<var: #destination type: #usqInt>
	<var: #maxFreeChunk type: #usqInt>
	here := startAddress.
	hereObj := self objectStartingAt: startAddress.
	hereObjHeader := self atLeastClassIndexHalfHeader: hereObj.
	prevPrevFreeChunk := prevFreeChunk := 0.
	thisFreeChunk := maxFreeChunk := firstFreeChunk.
	[thisFreeChunk ~= 0] whileTrue:
		[| freeBytes endOfFree nextFree destination there moved |

		 "skip any initial immobile objects"
		 [(self isMobileObjectHeader: hereObjHeader)] whileFalse:
			[here := self addressAfter: hereObj.
			 here >= limit ifTrue:
				[^maxFreeChunk >= startAddress ifTrue: [0] ifFalse: [limit]].
			 hereObj := self objectStartingAt: here.
			 hereObjHeader := self atLeastClassIndexHalfHeader: hereObj].

		 "grab a free chunk, and the following one, because we want to overwrite this one."
		 self assert: ((self isFreeObject: firstFreeChunk) and: [self isFreeObject: thisFreeChunk]).
		 freeBytes		:= self bytesInObject: thisFreeChunk.
		 nextFree		:= self nextInSortedFreeListLink: thisFreeChunk given: prevFreeChunk.
		 destination	:= self startOfObject: thisFreeChunk.
		 endOfFree		:= destination + freeBytes.
		 moved			:= false.
		 maxFreeChunk	:= maxFreeChunk max: nextFree.
		 self assert: (nextFree = 0 or: [self isFreeObject: nextFree]).

		"move as many objects as will fit in freeBytes..."
		 [there := self addressAfter: hereObj.
		  "N.B. *must* add allocationUnit, not subtract, to avoid unsigned arithmetic issues when freeBytes = 0"
		  (self isMobileObjectHeader: hereObjHeader)
		  and: [freeBytes > (there - here + self allocationUnit)
			    or: [freeBytes = (there - here)]]] whileTrue:
			[moved := true.
			 self mem: destination asVoidPointer cp: here asVoidPointer y: there - here.
			 self forwardUnchecked: hereObj to: destination + (hereObj - here).
			 destination := destination + (there - here).
			 freeBytes := freeBytes - (there - here).
			 hereObj := self objectStartingAt: there.
			 here := there.
			 hereObjHeader := self atLeastClassIndexHalfHeader: hereObj].

		 moved
			ifTrue: "we did overwrite it; we need to repair the free list"
				[| nextNextFree |
				 nextFree ~= 0 ifTrue:
					[nextNextFree  := self nextInSortedFreeListLink: nextFree given: thisFreeChunk.
					 self assert: (self isFreeObject: nextFree)].
				 (destination > thisFreeChunk "if false couldn't move anything"
				  and: [destination < endOfFree]) "if false, filled entire free chunk"
					ifTrue:
						[thisFreeChunk := self initFreeChunkWithBytes: endOfFree - destination at: destination.
						 self inSortedFreeListLink: prevFreeChunk to: thisFreeChunk given: prevPrevFreeChunk.
						 self inSortedFreeListLink: thisFreeChunk to: nextFree given: prevFreeChunk.
						 nextFree ~= 0 ifTrue:
							[self inSortedFreeListLink: nextFree to: nextNextFree given: thisFreeChunk].
						 prevPrevFreeChunk := prevFreeChunk.
						 prevFreeChunk := thisFreeChunk.
						 thisFreeChunk := nextFree]
					ifFalse:
						[self inSortedFreeListLink: prevFreeChunk to: nextFree given: prevPrevFreeChunk.
						 nextFree ~= 0 ifTrue:
							[self inSortedFreeListLink: nextFree to: nextNextFree given: prevFreeChunk].
						 thisFreeChunk := nextFree]]
			ifFalse: "out of space (or immobile object); move on up the free list..."
				[prevPrevFreeChunk := prevFreeChunk.
				 prevFreeChunk := thisFreeChunk.
				 thisFreeChunk := nextFree].

		 (self isMobileObjectHeader: hereObjHeader) ifFalse:
			[^maxFreeChunk >= startAddress ifTrue: [0] ifFalse: [there]].

		 "Was the loop stopped by a pig? If so, try and find space for it"
		 there - here >= (self averageObjectSizeInBytes * 8) ifTrue: "256b in 32 bit, 512b in 64 bit"
			[| usedChunk |
			 usedChunk := self tryToMovePig: hereObj at: here end: there.
			"if it couldn't be moved we need to advance, so always
			 set here to there whether the pig was moved or not."
			 hereObj := self objectStartingAt: there.
			 here := there.
			 hereObjHeader := self atLeastClassIndexHalfHeader: hereObj.
			 "In general it's a bad idea to reset the enumeration; it leads to N^2 behaviour
			  when encountering pigs.  But if the move affected the enumeration this is
			  simpler than resetting the list pointers."
			 (usedChunk = prevPrevFreeChunk
			  or: [usedChunk = prevFreeChunk
			  or: [usedChunk = thisFreeChunk]]) ifTrue:
				["reset the scan for free space back to the start of the list"
				 prevPrevFreeChunk := prevFreeChunk := 0.
				 thisFreeChunk := firstFreeChunk]].

		((here > startAddress and: [there >= limit])
		 or: [maxFreeChunk >= startAddress]) ifTrue:
			[^maxFreeChunk >= startAddress ifTrue: [0] ifFalse: [there]]].
	^here