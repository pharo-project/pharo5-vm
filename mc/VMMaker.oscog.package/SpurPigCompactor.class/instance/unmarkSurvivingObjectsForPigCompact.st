compaction
unmarkSurvivingObjectsForPigCompact
	manager allPastSpaceObjectsDo:
		[:objOop|
		(manager isMarked: objOop) ifTrue:
			[manager setIsMarkedOf: objOop to: false]]