compaction
prepareObjStackForPlanningCompactor: objStack
	"SpurPlanningCompactor overwrites the first fields of all moved objects, and saves these
	 fields in a data structure from which they can only be retrieved while scanning the heap.
	 The first field of an objStack page is its stack index, and so to know how many fields in an
	 objStack page to update it is necessary to save the ObjStackTopx field somewhere temporarily.
	 We use the hash field."

	| stackOrNil |
	objStack = nilObj ifTrue:
		[^self].
	stackOrNil := objStack.
	[self assert: (self numSlotsOfAny: stackOrNil) = ObjStackPageSlots.
	 self setHashBitsOf: stackOrNil to: (self fetchPointer: ObjStackTopx ofObject: stackOrNil).
	 (stackOrNil := self fetchPointer: ObjStackNextx ofObject: stackOrNil) ~= 0] whileTrue