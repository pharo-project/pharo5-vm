allocation accounting
setHeapSizeAtPreviousGC
	"heapSizeAtPreviousGC is used to invoke full GC when lots of oldSpace objects are created.
	 Also reset oldSpaceUsePriorToScavenge."
	<inline: true>
	heapSizeAtPreviousGC := segmentManager totalOldSpaceCapacity - totalFreeOldSpace.
	self resetAllocationAccountingAfterGC