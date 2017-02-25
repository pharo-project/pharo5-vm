growing/shrinking memory
firstGapOfSizeAtLeast: size
	"Answer the segment limit of the first segment followed by a gap of at least size bytes."
	0 to: numSegments - 2 do:
		[:i| | bridge |
		bridge := self bridgeAt: i.
		(manager bytesInObject: bridge) - manager bridgeSize >= size ifTrue:
			[^(segments at: i) segLimit asVoidPointer]].
	^(segments at: numSegments - 1) segLimit asVoidPointer