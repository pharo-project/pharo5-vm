compaction
relocateObjStackForPlanningCompactor: objStack
	"Relocate all objStack pages that cmprise objStack."
	| stackOrNil freeList next relocated result |
	objStack = nilObj ifTrue:
		[^objStack].
	stackOrNil := objStack.
	freeList := self fetchPointer: ObjStackFreex ofObject: objStack.
	[self assert: (self numSlotsOfAny: stackOrNil) = ObjStackPageSlots.
	 "There are four fixed slots in an obj stack, and a Topx of 0 indicates empty, so
	   if there were 5 slots in an oop stack, full would be 2, and the last 0-rel index is 4.
	   Hence the last index is topx + fixed slots - 1, or topx + ObjStackNextx"
	 next := self fetchPointer: ObjStackNextx ofObject: stackOrNil.
	 relocated := compactor
					relocateObjectsInHeapEntity: stackOrNil
					from: ObjStackFreex
					to: ObjStackNextx + (self rawHashBitsOf: stackOrNil).
	 stackOrNil = objStack ifTrue:
		[result := relocated].
	 self setHashBitsOf: stackOrNil to: 0.
	 next ~= 0]
		whileTrue:
			[stackOrNil := next].
	[freeList ~= 0] whileTrue:
		[self assert: (self numSlotsOfAny: freeList) = ObjStackPageSlots.
		 next := self fetchPointer: ObjStackFreex ofObject: freeList.
		 compactor
			relocateObjectsInHeapEntity: freeList
			from: ObjStackFreex
			to: ObjStackFreex.
		 freeList := next].
	^relocated