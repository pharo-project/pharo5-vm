growing/shrinking memory
attemptToShrink
	"Attempt to shrink memory after successfully reclaiming lots of memory."
	(totalFreeOldSpace > shrinkThreshold
	 and: [totalFreeOldSpace > growHeadroom]) ifTrue:
		[statShrinkMemory := statShrinkMemory + 1.
		 segmentManager shrinkObjectMemory: totalFreeOldSpace - growHeadroom]