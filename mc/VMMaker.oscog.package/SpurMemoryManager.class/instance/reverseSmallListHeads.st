free space
reverseSmallListHeads
	"After freeUnmarkedObjectsNilUnmarkedWeaklingSlotsAndSortAndCoalesceFreeSpace
	 all small free chunks will be on the free lists in reverse address order.  Reverse each list,
	 summing the ammount of space.  Answer the sum of bytes of free space on these small lists."
	| total |
	total := 0.
	freeListsMask := 0.
	1 to: self numFreeLists - 1 do:
		[:i| | bytes node prev next |
		 bytes := i * self allocationUnit.
		 node := freeLists at: i.
		 node ~= 0 ifTrue:
			[self assert: (self bytesInObject: node) = bytes.
			 freeListsMask := freeListsMask + (1 << i).
			 prev := 0.
			 [node ~= 0] whileTrue:
				[next := self fetchPointer: self freeChunkNextIndex ofFreeChunk: node.
				 self storePointer: self freeChunkNextIndex ofFreeChunk: node withValue: prev.
				 prev := node.
				 node := next.
				 total := total + bytes].
			 freeLists at: i put: prev]].
	^total