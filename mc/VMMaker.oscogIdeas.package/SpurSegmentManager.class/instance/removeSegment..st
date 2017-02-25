growing/shrinking memory
removeSegment: emptySeg
	<var: #emptySeg type: #'SpurSegmentInfo *'>
	| i |
	i := self indexOfSegment: emptySeg.
	self assert: i > 0.

	manager sqDeallocateMemorySegmentAt: emptySeg segStart asVoidPointer OfSize: emptySeg segSize.

	i to: numSegments - 1 do:
		[:j| segments at: j put: (segments at: j + 1)].
	self cCode: [] inSmalltalk: [segments at: numSegments - 1 put: SpurSegmentInfo new].
	numSegments := numSegments - 1.

	self bridgeFrom: (self addressOf: (segments at: i - 1))
		to: (i <= (numSegments - 1) ifTrue: [self addressOf: (segments at: i)]).

	manager setLastSegment: (self addressOf: (segments at: numSegments - 1))