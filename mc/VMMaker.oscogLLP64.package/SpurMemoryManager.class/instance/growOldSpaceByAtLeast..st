growing/shrinking memory
growOldSpaceByAtLeast: minAmmount
	"Attempt to grow memory by at least minAmmount.
	 Answer the size of the new segment, or nil if the attempt failed."
	| ammount headroom total |
	<var: #segInfo type: #'SpurSegmentInfo *'>
	"statGrowMemory counts attempts, not successes."
	statGrowMemory := statGrowMemory + 1."we need to include overhead for a new object header plus the segment bridge."
	ammount := minAmmount + (self baseHeaderSize * 2 + self bridgeSize).
	"round up to the nearest power of two."
	ammount := 1 << (ammount - 1) highBit.
	"and grow by at least growHeadroom."
	ammount := ammount max: growHeadroom.

	"Now apply the maxOldSpaceSize limit, if one is in effect."
	maxOldSpaceSize > 0 ifTrue:
		[total := segmentManager totalBytesInSegments.
		 total >= maxOldSpaceSize ifTrue:
			[^nil].
		 headroom := maxOldSpaceSize - total.
		 headroom < ammount ifTrue:
			[headroom < (minAmmount + (self baseHeaderSize * 2 + self bridgeSize)) ifTrue:
				[^nil].
			 ammount := headroom]].
		 
	^(segmentManager addSegmentOfSize: ammount) ifNotNil:
		[:segInfo|
		 self assimilateNewSegment: segInfo.
		 "and add the new free chunk to the free list; done here
		  instead of in assimilateNewSegment: for the assert"
		 self addFreeChunkWithBytes: segInfo segSize - self bridgeSize at: segInfo segStart.
		 self assert: (self addressAfter: (self objectStartingAt: segInfo segStart))
					= (segInfo segLimit - self bridgeSize).
		 self checkFreeSpace: GCModeFreeSpace.
		 segmentManager checkSegments.
		 segInfo segSize]