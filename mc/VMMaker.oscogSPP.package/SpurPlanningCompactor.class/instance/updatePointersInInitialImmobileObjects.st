compaction
updatePointersInInitialImmobileObjects
	"Sweep the initial immobile heap, updating all references to mobile objects to their eventual locations."
	manager allOldSpaceObjectsFrom: manager firstObject do:
		[:o|
		self check: o.
		o >= firstFreeObject ifTrue:
			[^self].
		self assert: (manager isMarked: o).
		self updatePointersIn: o]