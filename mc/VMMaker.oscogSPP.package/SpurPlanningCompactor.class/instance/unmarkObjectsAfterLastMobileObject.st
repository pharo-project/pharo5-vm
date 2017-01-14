compaction
unmarkObjectsAfterLastMobileObject
	"Sweep the final immobile heap, unmarking all objects up to the end of memory."
	manager allOldSpaceObjectsFrom: objectAfterLastMobileObject do:
		[:o|
		self check: o.
		manager setIsMarkedOf: o to: false]