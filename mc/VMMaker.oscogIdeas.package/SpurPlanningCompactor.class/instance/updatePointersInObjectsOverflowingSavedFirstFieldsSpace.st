compaction
updatePointersInObjectsOverflowingSavedFirstFieldsSpace
	"Sweep the final immobile heap, is any (those objects with no room in savedFirstFieldsSpace
	 in the current pass) updating all references to mobile objects to their eventual locations."
	manager allOldSpaceObjectsFrom: objectAfterLastMobileObject do:
		[:o|
		self check: o.
		(manager isMarked: o) ifTrue:
			[self updatePointersIn: o]]