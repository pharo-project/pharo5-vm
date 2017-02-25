snapshot
readHeapFromImageFile: f dataBytes: numBytes
	"Read numBytes of image data from f into memory at memoryBaseForImageRead.
	 Answer the number of bytes written.  In addition, read each segment, build up the
	 segment info for swizzling, while eliminating the bridge objects at the end of each
	 segment that specify the distance to and the size of the subsequent segment."
	<var: #f type: #sqImageFile>
	<inline: false>
	| bytesRead totalBytesRead bridgehead bridge nextSegmentSize oldBase newBase segInfo bridgeSpan |
	<var: 'segInfo' type: #'SpurSegmentInfo *'>
	self allocateOrExtendSegmentInfos.

	"segment sizes include the two-header-word bridge at the end of each segment."
	numSegments := totalBytesRead := 0.
	oldBase := 0. "N.B. still must be adjusted by oldBaseAddr."
	newBase := manager oldSpaceStart.
	nextSegmentSize := firstSegmentSize.
	bridgehead := firstSegmentSize + manager oldSpaceStart - manager bridgeSize.
	[segInfo := self addressOf: (segments at: numSegments).
	 segInfo
		segStart: oldBase;					"N.B. still must be adjusted by oldBaseAddr."
		segSize: nextSegmentSize;
		swizzle: newBase - oldBase.	"N.B. still must be adjusted by oldBaseAddr."
	 bytesRead := self readHeapFrom: f at: newBase dataBytes: nextSegmentSize.
	 bytesRead > 0 ifTrue:
			[totalBytesRead := totalBytesRead + bytesRead].
	 bytesRead ~= nextSegmentSize ifTrue:
		[^totalBytesRead].
	 (numSegments := numSegments + 1) >= numSegInfos ifTrue:
		[self allocateOrExtendSegmentInfos].
	 bridge := bridgehead + manager baseHeaderSize.
	 bridgeSpan := (manager rawNumSlotsOf: bridgehead) = 0
						ifTrue: [0]
						ifFalse: [manager bytesPerOop * (manager rawOverflowSlotsOf: bridge)].
	 oldBase := oldBase + nextSegmentSize + bridgeSpan.
	 newBase := newBase + nextSegmentSize - manager bridgeSize.
	 nextSegmentSize := (manager long64At: bridge) asUnsignedInteger.
	 nextSegmentSize ~= 0] whileTrue:
		[bridgehead := bridgehead - manager bridgeSize + nextSegmentSize].
	"newBase should point just past the last bridge. all others should have been eliminated."
	self assert: newBase - manager oldSpaceStart
				= (totalBytesRead - (numSegments * manager bridgeSize)).
	"set freeOldSpaceStart now for adjustAllOopsBy:"
	manager setFreeOldSpaceStart: newBase.
	"we're done. nil firstSegmentSize for a subsequent snapshot."
	firstSegmentSize := nil.
	^totalBytesRead