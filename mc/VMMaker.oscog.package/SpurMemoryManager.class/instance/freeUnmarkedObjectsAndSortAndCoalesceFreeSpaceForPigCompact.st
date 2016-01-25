gc - global
freeUnmarkedObjectsAndSortAndCoalesceFreeSpaceForPigCompact
	"Sweep all of old space, freeing unmarked objects, coalescing free chunks, and sorting free space.

	 Doubly-link the free chunks in address order through the freeChunkNextIndex field using the
	 xor trick to use only one field, see e.g.
		The Art of Computer Programming, Vol 1, D.E. Knuth, 3rd Ed, Sec 2.2.4 `Circular Lists', exercise. 18
		http://en.wikipedia.org/wiki/XOR_linked_list.
	 Record the lowest free object in firstFreeChunk and the highest in lastFreeChunk.

	 Let the segmentManager mark which segments contain pinned objects via notePinned:."

	| prevPrevFree prevFree |
	<inline: #never> "for profiling"
	self checkFreeSpace: GCModeFull.
	scavenger forgetUnmarkedRememberedObjects.
	self doScavenge: MarkOnTenure.
	segmentManager prepareForGlobalSweep."for notePinned:"
	"throw away the list heads, including the tree."
	self resetFreeListHeads.
	firstFreeChunk := prevPrevFree := prevFree := 0.
	self allOldSpaceEntitiesForCoalescingFrom: self firstObject do:
		[:o|
		 self assert: (firstFreeChunk = 0 or: [self isFreeObject: firstFreeChunk]).
		 (self isMarked: o)
			ifTrue: "forwarders should have been followed in markAndTrace:"
				[self assert: (self isForwarded: o) not.
				 self setIsMarkedOf: o to: false. "this will unmark bridges. undo the damage in notePinned:"
				 (self isPinned: o) ifTrue:
					[segmentManager notePinned: o]]
			ifFalse: "unmarked; two cases, an unreachable object or a free chunk."
				[| here |
				 self assert: (self isRemembered: o) not. "scavenger should have cleared this above"
				 here := self coallesceFreeChunk: o.
				 self setObjectFree: here.
				 self inSortedFreeListLink: prevFree to: here given: prevPrevFree.
				 prevPrevFree := prevFree.
				 prevFree := here]].
	prevFree ~= firstFreeChunk ifTrue:
		[self storePointer: self freeChunkNextIndex
			ofFreeChunk: prevFree
			withValue: prevPrevFree].
	lastFreeChunk := prevFree.
	self inSortedFreeListLink: lastFreeChunk to: 0 given: prevPrevFree.
	self assert: self checkTraversableSortedFreeList