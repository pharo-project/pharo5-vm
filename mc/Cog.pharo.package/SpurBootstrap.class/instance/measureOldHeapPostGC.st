stats
measureOldHeapPostGC
	oldHeapSize := oldHeap freeStart.
	oldHeapNumObjs := 0.
	oldHeap allObjectsDo: [:o| oldHeapNumObjs := oldHeapNumObjs + 1]