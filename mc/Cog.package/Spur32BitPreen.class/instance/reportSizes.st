bootstrap image
reportSizes
	| change oldHeapSize newHeapSize |
	oldHeapSize := oldHeap oldSpaceSize.
	newHeapSize := newHeap oldSpaceSize.
	change := newHeapSize - oldHeapSize / oldHeapSize.
	Transcript
		nextPutAll: 'done.'; cr;
		nextPutAll: 'old heap size: '; nextPutAll: oldHeapSize asStringWithCommas; tab;
		nextPutAll: 'initial new heap size: '; nextPutAll: newHeapSize asStringWithCommas; cr;
		nextPutAll: 'change: '; print: change * 100.0 maxDecimalPlaces: 2; nextPut: $%; cr;
		flush.
	newHeapSize := newHeap endOfMemory
					- newHeap scavenger eden limit
					- newHeap totalFreeListBytes.
	change := newHeapSize - oldHeapSize / oldHeapSize.
	Transcript
		nextPutAll: 'final new heap size: '; nextPutAll: newHeapSize asStringWithCommas; tab;
		nextPutAll: 'change: '; print: change * 100.0 maxDecimalPlaces: 2; nextPut: $%; cr;
		flush