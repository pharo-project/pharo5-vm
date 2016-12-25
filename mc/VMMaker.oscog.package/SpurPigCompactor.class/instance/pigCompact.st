compaction
pigCompact
	"Traverse the sorted free list, moving objects from the high-end of
	 memory to the free objects in the low end of memory.  Return when
	 the address at which objects are being copied to meets the address
	 from which objects are being copied from."
	self cCode: '' inSmalltalk: [coInterpreter transcript nextPutAll: 'pig compacting...'; flush].
	self sortedFreeListPairwiseReverseDo:
		[:low :high| | scanAddress |
		 self cCode: '' inSmalltalk: [coInterpreter transcript nextPut: $.; flush].
		 scanAddress := manager addressAfter: low.
		 [self oop: scanAddress isLessThan: high] whileTrue:
			[scanAddress := self moveARunOfObjectsStartingAt: scanAddress upTo: high.
			 scanAddress = 0 ifTrue:
				[^self]]].
	self assert: self checkTraversableSortedFreeList