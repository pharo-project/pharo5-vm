pinning
someSegmentContainsPinned
	0 to: numSegments - 1 do:
		[:i| (segments at: i) containsPinned ifTrue: [^true]].
	^false