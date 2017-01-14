growing/shrinking memory
attemptToShrink
	"Attempt to shrink memory after successfully reclaiming lots of memory.
	 If there's enough memory to shrink then be sure to attept to shrink by
	 at least growHeaqdroom because segments are typically of that size."
	(totalFreeOldSpace > shrinkThreshold
	 and: [totalFreeOldSpace > growHeadroom
	 and: [segmentManager shrinkObjectMemory: (totalFreeOldSpace - growHeadroom max: growHeadroom)]]) ifTrue:
		[statShrinkMemory := statShrinkMemory + 1]