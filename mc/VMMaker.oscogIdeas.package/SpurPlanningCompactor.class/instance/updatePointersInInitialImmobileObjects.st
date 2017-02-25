compaction
updatePointersInInitialImmobileObjects
	"Sweep the initial immobile heap, updating all references to mobile objects to their eventual locations."
	manager allOldSpaceObjectsFrom: manager firstObject do:
		[:o|
		self check: o.
		(self oop: o isGreaterThanOrEqualTo: firstFreeObject) ifTrue:
			[^self].
		"would like to assert this, but it isn't true if more than one pass: self assert: (manager isMarked: o)."
		self updatePointersIn: o]