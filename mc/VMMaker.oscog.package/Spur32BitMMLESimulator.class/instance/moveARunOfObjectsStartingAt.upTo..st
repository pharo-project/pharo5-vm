compaction
moveARunOfObjectsStartingAt: startAddress upTo: limit
	| result |.
	"self checkTraversableSortedFreeList."
	result := super moveARunOfObjectsStartingAt: startAddress upTo: limit.
	"self checkTraversableSortedFreeList."
	^result