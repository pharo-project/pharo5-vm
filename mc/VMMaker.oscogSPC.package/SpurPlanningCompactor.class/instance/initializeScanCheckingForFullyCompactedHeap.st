compaction
initializeScanCheckingForFullyCompactedHeap
	"Scan for firstFreeObject and firstMobileObject from the start of memory.
	 Answer if the heap is already fully compacted."
	firstMobileObject := lastMobileObject := objectAfterLastMobileObject := nil.
	self reinitializeScanFrom: manager hiddenRootsObject.
	firstFreeObject ifNil:
		[self error: 'uncompactable heap; no unmarked objects found'].
	^firstMobileObject >= manager endOfMemory