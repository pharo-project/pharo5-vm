bootstrap image
fillInHeap
	| heapEnd freeListsObj |
	heapEnd := heap64 freeStart.
	heap64
		nilObject: (map at: heap32 nilObject);
		falseObject: (map at: heap32 falseObject);
		trueObject: (map at: heap32 trueObject);
		specialObjectsOop: (map at: heap32 specialObjectsOop);
		lastHash: heap32 lastHash;
		setHiddenRootsObj: (map at: heap32 classTableRootObj).
	heap64 segmentManager
		initSegmentForInImageCompilationFrom: heap64 nilObject
		to: heapEnd + heap64 bridgeSize.
	freeListsObj := heap64 objectAfter: heap64 trueObject.
	"Nil-out the free lists."
	heap64
		fillObj: freeListsObj numSlots: (heap64 numSlotsOf: freeListsObj) with: 0;
		initializeFreeSpacePostLoad: freeListsObj;
		initializePostBootstrap;
		setEndOfMemory: (heap64 segmentManager bridgeAt: 0) + heap64 baseHeaderSize