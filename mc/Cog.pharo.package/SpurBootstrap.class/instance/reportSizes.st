bootstrap image
reportSizes
	| change oldAvgBytes newAvgBytes |
	change := newHeapSize - oldHeapSize / oldHeapSize.
	oldAvgBytes := oldHeapSize asFloat / oldHeapNumObjs.
	Transcript
		nextPutAll: 'done.'; cr;
		nextPutAll: 'old heap size: '; print: oldHeapSize; tab;
		nextPutAll: ' (avg obj bytes '; print: (oldAvgBytes roundTo: 0.01); nextPutAll: ' words '; print: (oldAvgBytes / self wordSize roundTo: 0.01); nextPut: $); cr;
		nextPutAll: 'initial new heap size: '; print: newHeapSize; cr;
		nextPutAll: 'change: '; print: (change * 100.0 roundTo: 0.01); nextPut: $%; cr;
		flush.
	newHeapSize := newHeap endOfMemory
					- newHeap scavenger eden limit
					- newHeap totalFreeListBytes.
	change := newHeapSize - oldHeapSize / oldHeapSize.
	newAvgBytes := newHeapSize asFloat / newHeapNumObjs.
	Transcript
		nextPutAll: 'final new heap size: '; print: newHeapSize; tab;
		nextPutAll: ' (avg obj bytes '; print: (newAvgBytes roundTo: 0.01); nextPutAll: ' words '; print: (newAvgBytes / self wordSize roundTo: 0.01); nextPut: $); cr;
		nextPutAll: 'change: '; print: (change * 100.0 roundTo: 0.01); nextPut: $%; cr;
		flush