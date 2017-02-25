accessing
segmentContainingObj: objOop
	<export: true>
	<returnTypeC: #'SpurSegmentInfo *'>
	numSegments - 1 to: 0 by: -1 do:
		[:i|
		objOop >= (segments at: i) segStart ifTrue:
			[^self addressOf: (segments at: i)]].
	^nil