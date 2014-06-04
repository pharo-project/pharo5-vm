snapshot
totalBytesInNonEmptySegments
	| total |
	total := 0.
	0 to: numSegments - 1 do:
		[:i|
		(segments at: i) segSize > manager bridgeSize ifTrue:
			[total := total + (segments at: i) segSize]].
	^total