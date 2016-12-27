compaction
initializeScanCheckingForFullyCompactedHeap
	"Scan for firstFreeObject and firstMobileObject from the start of memory.
	 Answer if the heap is already fully compacted."
	firstFreeObject := manager hiddenRootsObject.
	self reinitializeScan.
	^firstMobileObject >= manager endOfMemory