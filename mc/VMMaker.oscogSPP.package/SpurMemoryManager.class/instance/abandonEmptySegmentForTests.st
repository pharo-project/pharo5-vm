simulation tests support
abandonEmptySegmentForTests
	"Assume a freshly-loaded image. Eliminate the last segment."
	<doNotGenerate>
	| freeChunk emptySeg |
	freeChunk := self findLargestFreeChunk.
	self assert: totalFreeOldSpace = (self bytesInObject: freeChunk).
	self assert: endOfMemory = (self addressAfter: freeChunk).
	self unlinkSolitaryFreeTreeNode: freeChunk.
	segmentManager numSegments > 1
		ifTrue:
			[emptySeg := segmentManager findEmptySegNearestInSizeTo: (self bytesInObject: freeChunk).
			 segmentManager removeSegment: emptySeg]
		ifFalse:
			[(segmentManager segments at: 0)
				segSize: (segmentManager segments at: 0) segSize - (self bytesInObject: freeChunk).
			 self setLastSegment: (segmentManager segments at: 0);
			 	initSegmentBridgeWithBytes: self bridgeSize at: (self startOfObject: freeChunk)]