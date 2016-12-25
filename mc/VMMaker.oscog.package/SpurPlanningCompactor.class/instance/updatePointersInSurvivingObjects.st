compaction
updatePointersInSurvivingObjects
	"Sweep pastSpace, updating all references to mobile objects to their eventual locations."
	manager allPastSpaceObjectsDo:
		[:o|
		self assert: (manager isMarked: o).
		self updatePointersIn: o startingAt: 0 savedFirstFieldPointer: nil]