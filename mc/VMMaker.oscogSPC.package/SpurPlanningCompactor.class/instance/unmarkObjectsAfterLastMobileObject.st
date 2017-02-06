compaction
unmarkObjectsAfterLastMobileObject
	"Sweep the final immobile heap, freeing and coalescing unmarked and free objects,
	 and unmarking all marked objects up to the end of memory."
	| startOfFree freeBytes |
	freeBytes := 0.
	manager allOldSpaceEntitiesFrom: objectAfterLastMobileObject do:
		[:o|
		self check: o.
		(manager isMarked: o)
			ifFalse:
				[startOfFree ifNil: [startOfFree := manager startOfObject: o].
				 freeBytes := freeBytes + manager bytesInObject: o]
			ifTrue:
				[startOfFree ifNotNil:
					[manager addFreeChunkWithBytes: freeBytes at: startOfFree.
					 startOfFree := nil.
					 freeBytes := 0].
				 (manager isSegmentBridge: o) ifFalse:
					[manager setIsMarkedOf: o to: false]]]