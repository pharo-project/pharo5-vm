simulation only
initializeFreeSpaceForFacadeFrom: base to: limit
	"c.f. initializeFreeSpacePostLoad: freeListObj."
	| freeListObj freeBytes |
	newSpaceLimit := oldSpaceStart := freeStart := base.
	endOfMemory := limit.
	scavengeThreshold := limit * 3 // 4.
	segmentManager initSegmentForInImageCompilationFrom: base to: limit.
	freeListObj := self allocateSlots: self numFreeLists
						format: self wordIndexableFormat
						classIndex: self wordSizeClassIndexPun.
	freeLists := self firstIndexableField: freeListObj.
	freeListsMask := 0.
	0 to: self numFreeLists - 1 do:
		[:i|
		(freeLists at: i) ~= 0 ifTrue:
			[freeListsMask := freeListsMask bitOr: (1 << i).
			 freeLists at: i put: (segmentManager swizzleObj: (freeLists at: i))]].
	freeBytes := segmentManager lastSegment segLimit - self bridgeSize - freeStart.
	freeLists at: 0 put: (self initFreeChunkWithBytes: freeBytes at: freeStart).
	totalFreeOldSpace := freeBytes