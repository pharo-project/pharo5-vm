compaction
updatePointersInSurvivingObjects
	"Sweep pastSpace, updating all references to mobile objects to their eventual locations."
	manager allPastSpaceObjectsDo:
		[:o|
		self check: o.
		self assert: (manager isMarked: o).
		self updatePointersIn: o]