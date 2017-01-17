growing/shrinking memory
addSegmentOfSize: ammount
	<returnTypeC: #'SpurSegmentInfo *'>
	<inline: false>
	| allocatedSize |
	<var: #newSeg type: #'SpurSegmentInfo *'>
	<var: #segAddress type: #'void *'>
	<var: #allocatedSize type: #'usqInt'>
	self cCode: [] inSmalltalk: [segments ifNil: [^nil]]. "bootstrap"
	(manager "sent to the manager so that the simulator can increase memory to simulate a new segment"
			sqAllocateMemorySegmentOfSize: ammount
			Above: (self firstGapOfSizeAtLeast: ammount)
			AllocatedSizeInto: (self cCode: [self addressOf: allocatedSize]
									inSmalltalk: [[:sz| allocatedSize := sz]])) ifNotNil:
		[:segAddress| | newSegIndex newSeg |
		 newSegIndex := self insertSegmentFor: segAddress asUnsignedIntegerPtr.
		 newSeg := self addressOf: (segments at: newSegIndex).
		 newSeg
			segStart: segAddress asUnsignedIntegerPtr;
			segSize: allocatedSize.
		 self bridgeFrom: (self addressOf: (segments at: newSegIndex - 1)) to: newSeg.
		 self bridgeFrom: newSeg to: (newSegIndex = (numSegments - 1) ifFalse:
										[self addressOf: (segments at: newSegIndex + 1)]).
		 "test isInMemory:"
		 0 to: numSegments - 1 do:
			[:i|
			self assert: (self isInSegments: (segments at: i) segStart).
			self assert: (self isInSegments: (segments at: i) segLimit - manager wordSize).
			self assert: ((self isInSegments: (segments at: i) segLimit) not
						or: [i < (numSegments - 1)
							and: [(segments at: i) segLimit = (segments at: i + 1) segStart]]).
			self assert: ((self isInSegments: (segments at: i) segStart - manager wordSize) not
							or: [i > 0
								and: [(segments at: i - 1) segLimit = (segments at: i) segStart]])].
		 ^newSeg].
	^nil