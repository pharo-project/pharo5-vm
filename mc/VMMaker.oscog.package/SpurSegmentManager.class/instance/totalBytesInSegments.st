snapshot
totalBytesInSegments
	| total |
	total := 0.
	0 to: numSegments - 1 do:
		[:i|
		total := total + (segments at: i) segSize].
	^total