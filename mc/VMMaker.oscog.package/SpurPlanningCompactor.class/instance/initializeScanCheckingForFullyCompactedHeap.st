compaction
initializeScanCheckingForFullyCompactedHeap
	"Scan for firstFreeObject and firstMobileObject from the start of memory (actually
	 from lastMobileObject so that reInitializeScan can work on subsequent passes).
	 Answer if the heap is already fully compacted.  Set "
	firstFreeObject := lastMobileObject := manager hiddenRootsObject.
	self reinitializeScan.
	^firstMobileObject >= manager endOfMemory