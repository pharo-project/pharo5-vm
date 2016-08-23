snapshot
prepareForSnapshot
	"shorten all segments by any trailing free space."
	<inline: #never>
	<var: #seg type: #'SpurSegmentInfo *'>
	self checkSegments.
	0 to: numSegments - 1 do:
		[:i|
		 (segments at: i)
			savedSegSize: (segments at: i) segSize;
			lastFreeObject: nil].

	"Ideally finding the lastFreeObject of each segment would be
	 done in some linear pass through the heap.  But for now KISS."
	manager freeTreeNodesDo:
		[:freeChunk| | node next seg |
		 node := freeChunk.
		 [node ~= 0] whileTrue:
			[next := manager objectAfter: node limit: manager endOfMemory.
			 (manager isSegmentBridge: next)
				ifTrue:
					[seg := self segmentContainingObj: node.
					 seg lastFreeObject: node.
					 node := 0]
				ifFalse:
					[node := manager
								fetchPointer: manager freeChunkNextIndex
								ofFreeChunk: node]].
		 freeChunk].

	0 to: numSegments - 1 do:
		[:i|
		 (segments at: i) lastFreeObject ifNotNil:
			[:freeChunk|
			manager detachFreeObject: freeChunk.
			(segments at: i)
				segSize: (manager startOfObject: freeChunk)
						+ manager bridgeSize
						- (segments at: i) segStart.
			self bridgeFrom: (self addressOf: (segments at: i))
				to: (i < (numSegments - 1) ifTrue: [self addressOf: (segments at: i + 1)])]].

	"perhaps this should read
		manager setEndOfMemory: 0; assimilateNewSegment: (segments at: numSegments - 1)"
	manager setEndOfMemory: (segments at: numSegments - 1) segLimit - manager bridgeSize