compaction
unmarkSurvivingObjectsForCompact
	self allPastSpaceObjectsDo:
		[:objOop|
		(self isMarked: objOop) ifTrue:
			[self setIsMarkedOf: objOop to: false]]