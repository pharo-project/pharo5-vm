allocation accounting
currentAllocatedBytes
	"Compute the current allocated bytes since last set.
	 This is the cumulative total in statAllocatedBytes plus the allocation since the last scavenge."
	| use |
	use := segmentManager totalOldSpaceCapacity - totalFreeOldSpace.
	^statAllocatedBytes
	 + (freeStart - scavenger eden start)
	 + (use - oldSpaceUsePriorToScavenge)