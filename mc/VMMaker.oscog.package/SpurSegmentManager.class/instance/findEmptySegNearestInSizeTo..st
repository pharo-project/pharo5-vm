growing/shrinking memory
findEmptySegNearestInSizeTo: size
	| seg best delta |
	<var: #seg type: #'SpurSegmentInfo *'>
	<var: #best type: #'SpurSegmentInfo *'>
	best := nil.
	delta := size.
	0 to: numSegments - 1 do:
		[:i|
		seg := self addressOf: (segments at: i).
		(self isEmptySegment: seg) ifTrue:
			[best
				ifNil: [best := seg]
				ifNotNil:
					[(size >= (seg segSize * 0.75)
					 and: [(self cCoerce: (seg segSize - size) to: #sqInt ) abs < delta]) ifTrue:
						[best := seg. delta := (self cCoerce: (seg segSize - size) to: #sqInt ) abs]]]].
	^best