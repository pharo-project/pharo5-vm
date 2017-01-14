snapshot
writeImageSegmentsToFile: aBinaryStream
	<var: 'aBinaryStream' type: #sqImageFile>
	<inline: false>
	| total |
	self assert: (manager endOfMemory = (segments at: numSegments - 1) segLimit
				 or: [manager endOfMemory + manager bridgeSize = (segments at: numSegments - 1) segLimit]).
	firstSegmentSize ifNotNil:
		[self assert: firstSegmentSize = (segments at: 0) segSize].
	self assert: (segments at: 0) segSize > 0.
	total := 0.
	0 to: numSegments - 1 do:
		[:i|
		(segments at: i) segSize > manager bridgeSize ifTrue:
			[total := total + (self writeSegment: (self addressOf: (segments at: i))
								nextSegment: (self nextNonEmptySegmentAfter: i)
								toFile: aBinaryStream)]].
	^total