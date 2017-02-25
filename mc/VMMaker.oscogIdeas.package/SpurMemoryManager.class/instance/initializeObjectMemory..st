initialization
initializeObjectMemory: bytesToShift
	"Initialize object memory variables at startup time. Assume endOfMemory at al are
	 initialised by the image-reading code via setHeapBase:memoryLimit:endOfMemory:.
	 endOfMemory is assumed to point to the end of the last object in the image.
	 Assume: image reader also initializes the following variables:
		specialObjectsOop
		lastHash"
	<inline: false>
	| freeListObj |
	"Catch mis-initializations leading to bad translations to C"
	self assert: self baseHeaderSize = self baseHeaderSize.
	self assert: (self maxSlotsForAlloc * self wordSize) asInteger > 0.
	self bootstrapping ifFalse:
		[self
			initSegmentBridgeWithBytes: self bridgeSize
			at: endOfMemory - self bridgeSize].
	segmentManager adjustSegmentSwizzlesBy: bytesToShift.
	"image may be at a different address; adjust oops for new location"
	self adjustAllOopsBy: bytesToShift.
	specialObjectsOop := segmentManager swizzleObj: specialObjectsOop.

	"heavily used special objects"
	nilObj		:= self splObj: NilObject.
	falseObj	:= self splObj: FalseObject.
	trueObj		:= self splObj: TrueObject.

	"In Cog we insist that nil, true & false are next to each other (Cogit generates tighter
	 conditional branch code as a result).  In addition, Spur places the free lists and
	 class table root page immediately following them."
	self assert: nilObj = oldSpaceStart.
	self assert: falseObj = (self oldSpaceObjectAfter: nilObj).
	self assert: trueObj = (self oldSpaceObjectAfter: falseObj).
	freeListObj := self oldSpaceObjectAfter: trueObj.
	self setHiddenRootsObj: (self oldSpaceObjectAfter: freeListObj).
	markStack := self swizzleObjStackAt: MarkStackRootIndex.
	weaklingStack := self swizzleObjStackAt: WeaklingStackRootIndex.
	mournQueue := self swizzleObjStackAt: MournQueueRootIndex.
	self assert: self validObjStacks.
	self assert: (self isEmptyObjStack: markStack).
	self assert: (self isEmptyObjStack: weaklingStack).

	self initializeFreeSpacePostLoad: freeListObj.
	segmentManager collapseSegmentsPostSwizzle.
	self computeFreeSpacePostSwizzle.
	self initializeOldSpaceFirstFree: freeOldSpaceStart. "initializes endOfMemory, freeStart, free space"
	self initializeNewSpaceVariables.
	scavenger initializeRememberedSet.
	segmentManager checkSegments.
	compactor biasForGC.

	"These defaults should depend on machine size; e.g. too small on a powerful laptop, too big on a Pi."
	growHeadroom := 16*1024*1024.		"headroom when growing"
	shrinkThreshold := 32*1024*1024.		"free space before shrinking"
	self setHeapSizeAtPreviousGC.
	heapGrowthToSizeGCRatio := 0.333333. "By default GC after scavenge if heap has grown by a third since the last GC"