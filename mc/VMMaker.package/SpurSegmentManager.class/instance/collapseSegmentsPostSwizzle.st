snapshot
collapseSegmentsPostSwizzle
	"The image has been loaded, old segments reconstructed, and the heap
	 swizzled into a single contiguous segment.  Collapse the segments into one."
	<inline: false>
	canSwizzle := false.
	self cCode: []
		inSmalltalk:
			[segments ifNil:
				[self allocateOrExtendSegmentInfos]].
	numSegments := 1.
	(segments at: 0)
		segStart: manager oldSpaceStart;
		segSize: manager endOfMemory - manager oldSpaceStart.
	manager bootstrapping ifTrue:
		["finally plant a bridge at the end of the coalesced segment and cut back the
		  manager's notion of the end of memory to immediately before the bridge."
		 self assert: manager endOfMemory = (segments at: 0) segLimit.
		 manager
			initSegmentBridgeWithBytes: manager bridgeSize
			at: manager endOfMemory - manager bridgeSize].
	self assert: (manager isSegmentBridge: (self bridgeAt: 0)).
	self assert: (manager numSlotsOfAny: (self bridgeAt: 0)) = 0