compaction
updatePointersInObjectsOverflowingSavedFirstFieldsSpace
	"Sweep the final immobile heap, is any (those objects with no room in savedFirstFieldsSpace
	 in the current pass) updating all references to mobile objects to their eventual locations."
	manager allOldSpaceObjectsFrom: (manager objectAfter: lastMobileObject) do:
		[:o|
		self check: o.
		self assert: (manager isMarked: o).
		self updatePointersIn: o]