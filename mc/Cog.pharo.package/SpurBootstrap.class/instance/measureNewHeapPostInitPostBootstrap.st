stats
measureNewHeapPostInitPostBootstrap
	| savedEndOfMemory |
	"need to hack around the fact that newHeap isn't all there yet.
	 In particular, it has no freeList so can't free space from
	 freeOldSpaceStart to endOfMemory to make oldSpace enumerable."
	newHeapNumObjs := 0.
	savedEndOfMemory := newHeap endOfMemory.
	newHeap setEndOfMemory: newHeap freeOldSpaceStart.
	newHeap allObjectsDo: [:o| newHeapNumObjs := newHeapNumObjs + 1].
	newHeap setEndOfMemory: savedEndOfMemory