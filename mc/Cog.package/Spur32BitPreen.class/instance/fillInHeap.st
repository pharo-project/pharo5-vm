bootstrap image
fillInHeap
	| heapEnd freeListsObj |
	heapEnd := newHeap freeStart.
	newHeap
		nilObject: (map at: oldHeap nilObject);
		falseObject: (map at: oldHeap falseObject);
		trueObject: (map at: oldHeap trueObject);
		specialObjectsOop: (map at: oldHeap specialObjectsOop);
		lastHash: oldHeap lastHash;
		setHiddenRootsObj: (map at: oldHeap classTableRootObj).
	newHeap segmentManager
		initSegmentForInImageCompilationFrom: newHeap nilObject
		to: heapEnd + newHeap bridgeSize.
	freeListsObj := newHeap objectAfter: newHeap trueObject.
	"Nil-out the free lists."
	newHeap
		fillObj: freeListsObj numSlots: (newHeap numSlotsOf: freeListsObj) with: 0;
		initializeFreeSpacePostLoad: freeListsObj;
		initializePostBootstrap;
		setEndOfMemory: (newHeap segmentManager bridgeAt: 0) + newHeap baseHeaderSize