snapshot
writeSegment: segment nextSegment: nextSegment toFile: aBinaryStream
	"Write the segment contents, the size of and the distance to the next segment to aBinaryStream."
	<var: 'segment' type: #'SpurSegmentInfo *'>
	<var: 'nextSegment' type: #'SpurSegmentInfo *'>
	<var: 'aBinaryStream' type: #sqImageFile>
	| pier1 pier2 firstSavedBridgeWord secondSavedBridgeWord nWritten |
	<var: 'firstSavedBridgeWord' type: #usqLong>
	<var: 'secondSavedBridgeWord' type: #usqLong>
	pier1 := segment segLimit - manager bridgeSize.
	pier2 := pier1 + manager baseHeaderSize.
	self assert: (self isValidSegmentBridge: (self bridgeFor: segment)).
	self assert: (manager startOfObject: (self bridgeFor: segment)) = pier1.
	"Temporarily change the bridge to bridge to the next non-empty segment.
	 The first double word of the bridge includes the bridge size in slots, and
	 hence specifies the distance to the next segment. The following double
	 word is replaced by the size of the next segment, or 0 if there isn't one."
	firstSavedBridgeWord := manager long64At: pier1.
	secondSavedBridgeWord := manager long64At: pier2.
	self bridgeFrom: segment to: nextSegment.
	manager
		long64At: pier2
		put: (nextSegment ifNil: [0] ifNotNil: [nextSegment segSize]).
	nWritten := self cCode:
						[self
							sq: segment segStart asVoidPointer
							Image: 1
							File: segment segSize
							Write: aBinaryStream]
					inSmalltalk:
						[aBinaryStream
							next: segment segSize / 4
							putAll: manager memory
							startingAt: segment segStart / 4 + 1.
						 segment segSize].
	manager
		long64At: pier1 put: firstSavedBridgeWord;
		long64At: pier2 put: secondSavedBridgeWord.
	^nWritten