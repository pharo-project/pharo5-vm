compaction
unmarkInitialImmobileObjects
	"Sweep the initial immobile heap, unmarking all objects up to the first mobile object."
	manager allOldSpaceObjectsFrom: manager firstObject do:
		[:o|
		self check: o.
		(self oop: o isGreaterThanOrEqualTo: firstMobileObject) ifTrue:
			[^self].
		manager setIsMarkedOf: o to: false]