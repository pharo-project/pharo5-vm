object memory support
postGCAction
	"Shrink free memory, signal the gc semaphore and let the Cogit do its post GC thang"
	| freeSizeNow |

	freeSizeNow := objectMemory freeSize.
	(freeSizeNow > objectMemory shrinkThreshold
	 and: [freeSizeNow > objectMemory growHeadroom]) ifTrue:
		["Attempt to shrink memory after successfully reclaiming lots of memory"
		 objectMemory shrinkObjectMemory: freeSizeNow - objectMemory growHeadroom].

	cogit cogitPostGCAction: gcMode.

	self signalSemaphoreWithIndex: gcSemaphoreIndex.

	lastCoggableInterpretedBlockMethod := lastUncoggableInterpretedBlockMethod := nil.

	gcMode := 0