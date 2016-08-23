snapshot
postSnapshot
	"Restore all shortened segments to their proper size, re-freeing the trailing space."
	<inline: false>
	| seg |
	<var: #seg type: #'SpurSegmentInfo *'>
	"Set endOfMemory first, to avoid assert fails in freeChunkWithBytes:at:."
	seg := self addressOf: (segments at: numSegments - 1).
	seg lastFreeObject
		ifNil: [self assert: manager endOfMemory = (seg segLimit - manager bridgeSize)]
		ifNotNil: [manager setEndOfMemory: seg savedSegSize + seg segStart - manager bridgeSize].

	numSegments - 1 to: 0 by: -1 do:
		[:i|
		 seg := self addressOf: (segments at: i).
		 seg lastFreeObject ifNotNil:
			[:freeChunk| | address |
			address := seg segLimit - manager bridgeSize.
			seg segSize: seg savedSegSize.
			self bridgeFrom: seg
				to: (i < (numSegments - 1) ifTrue: [self addressOf: (segments at: i + 1)]).
			manager
				addFreeChunkWithBytes: seg segLimit - address - manager bridgeSize
				at: address]].
	self checkSegments.
	manager checkFreeSpace: GCModeFull