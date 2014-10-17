snapshot
totalBytesInSegments
	| total |
	<var: #total type: #usqInt>
	total := 0.
	0 to: numSegments - 1 do:
		[:i|
		total := total + (segments at: i) segSize].
	^total