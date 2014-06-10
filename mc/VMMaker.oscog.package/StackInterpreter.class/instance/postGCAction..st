object memory support
postGCAction: gcModeArg
	"Shrink free memory and signal the gc semaphore"

	(gcModeArg = GCModeFull or: [gcModeArg = GCModeIncr]) ifTrue:"but *not* become and *not* scavenge"
		[| freeSizeNow |
		 freeSizeNow := objectMemory freeSize.
		 (freeSizeNow > objectMemory shrinkThreshold
		  and: [freeSizeNow > objectMemory growHeadroom]) ifTrue:
			["Attempt to shrink memory after successfully reclaiming lots of memory"
			 objectMemory shrinkObjectMemory: freeSizeNow - objectMemory growHeadroom]].

	self signalSemaphoreWithIndex: gcSemaphoreIndex