initialization
initializeObjectMemory: bytesToShift
	"Initialize object memory variables at startup time. Assume endOfMemory is initially set (by the image-reading code) to the end of the last object in the image. Initialization redefines endOfMemory to be the end of the object allocation area based on the total available memory, but reserving some space for forwarding blocks."
	"Assume: image reader initializes the following variables:
		memory
		memoryLimit
		specialObjectsOop
		lastHash
	"
	<inline: false>
	| freeListObj |
	"Catch mis-initializations leading to bad translations to C"
	self assert: BaseHeaderSize = self baseHeaderSize.
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
	self assert: falseObj = (self objectAfter: nilObj).
	self assert: trueObj = (self objectAfter: falseObj).
	freeListObj := self objectAfter: trueObj.
	self reInitializeClassTablePostLoad: (self objectAfter: freeListObj).
	markStack := self swizzleObjStackAt: MarkStackRootIndex.
	weaklingStack := self swizzleObjStackAt: WeaklingStackRootIndex.
	ephemeronQueue := self swizzleObjStackAt: EphemeronQueueRootIndex.
	self assert: self validObjStacks.
	self assert: (self isEmptyObjStack: markStack).
	self assert: (self isEmptyObjStack: weaklingStack).

	self initializeFreeSpacePostLoad: freeListObj.
	segmentManager collapseSegmentsPostSwizzle.
	self computeFreeSpacePostSwizzle.
	self bootstrapping ifFalse:
		[self initializeNewSpaceVariables].
	self initializeOldSpaceFirstFree: freeOldSpaceStart. "initializes endOfMemory, freeStart"
	segmentManager checkSegments.

	"These defaults should depend on machine size; e.g. too small on a powerful laptop, too big on a Pi."
	growHeadroom := 16*1024*1024.		"headroom when growing"
	shrinkThreshold := 32*1024*1024.		"free space before shrinking"
	self setHeapSizeAtPreviousGC.
	heapGrowthToSizeGCRatio := 0.333333. "By default GC after scavenge if heap has grown by a third since the last GC"