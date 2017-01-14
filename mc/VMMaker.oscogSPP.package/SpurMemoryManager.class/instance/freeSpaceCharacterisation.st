debug support
freeSpaceCharacterisation
	<doNotGenerate>
	| n s |
	n := 0.
	s := Bag new.
	self allFreeObjectsDo:
		[:f| n := n + 1. s add: (self bytesInObject: f)].
	^{ n. s sortedCounts. s sortedElements }