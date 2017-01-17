growing/shrinking memory
indexOfSegment: seg
	<var: #seg type: #'SpurSegmentInfo *'>
	0 to: numSegments - 1 do:
		[:i|
		seg segStart = (segments at: i) segStart ifTrue:
			[^i]].
	self error: 'segment not found'