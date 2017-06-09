allocation accounting
resetAllocationAccountingAfterGC
	"oldSpaceUsePriorToScavenge is used to maintain an accurate allocation count.
	 Since scavenging may tenure objects and tenuring does not count as allocation (that
	 would count twice) we must compute heapSizeAtPreviousGC after any tenuring.
	 fullGC reclaims space which does not count as deallocation (that would not count
	 allocations at all), so we must reset heapSizeAtPreviousGC after GC also."
	<inline: true>
	oldSpaceUsePriorToScavenge := segmentManager totalOldSpaceCapacity - totalFreeOldSpace