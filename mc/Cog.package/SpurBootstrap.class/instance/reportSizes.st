bootstrap image
reportSizes
	| change oldAvgBytes newAvgBytes |
	change := newHeapSize - oldHeapSize / oldHeapSize.
	oldAvgBytes := oldHeapSize asFloat / oldHeapNumObjs.
	Transcript
		nextPutAll: 'done.'; cr;
		nextPutAll: 'old heap size: '; nextPutAll: oldHeapSize asStringWithCommas; tab;
		nextPutAll: ' (avg obj bytes '; print: oldAvgBytes maxDecimalPlaces: 2; nextPutAll: ' words '; print: oldAvgBytes / self wordSize maxDecimalPlaces: 2; nextPut: $); cr;
		nextPutAll: 'initial new heap size: '; nextPutAll: newHeapSize asStringWithCommas; cr;
		nextPutAll: 'change: '; print: change * 100.0 maxDecimalPlaces: 2; nextPut: $%; cr;
		flush.
	newHeapSize := newHeap endOfMemory
					- newHeap scavenger eden limit
					- newHeap totalFreeListBytes.
	change := newHeapSize - oldHeapSize / oldHeapSize.
	newAvgBytes := newHeapSize asFloat / newHeapNumObjs.
	Transcript
		nextPutAll: 'final new heap size: '; nextPutAll: newHeapSize asStringWithCommas; tab;
		nextPutAll: ' (avg obj bytes '; print: newAvgBytes maxDecimalPlaces: 2; nextPutAll: ' words '; print: newAvgBytes / self wordSize maxDecimalPlaces: 2; nextPut: $); cr;
		nextPutAll: 'change: '; print: change * 100.0 maxDecimalPlaces: 2; nextPut: $%; cr;
		flush