image segment in/out
ifAProxy: objOop updateCopy: copy
	"This is part of storeImageSegmentInto:outPointers:roots:.
	 If the object being copied to the segment is weird and has exotic state,
	 i.e. a married context or a jitted method, update the copy with the vanilla state."

	((self isContext: objOop)
	 and: [coInterpreter isMarriedOrWidowedContext: objOop]) ifTrue:
		[| numMediatedSlots |
		 "Since the context is here via objectsReachableFromRoots: we know it cannot be divorced.
		  I'd like to assert coInterpreter checkIsStillMarriedContext: objOop currentFP: framePointer,
		  here but that requires access to framePointer."
		 numMediatedSlots := coInterpreter numSlotsOfMarriedContext: objOop.
		 0 to: numMediatedSlots - 1 do:
			[:i| | oop |
			 oop := coInterpreter fetchPointer: i ofMarriedContext: objOop.
			 self storePointerUnchecked: i ofObject: copy withValue: oop].
		 "And make sure to nil the slots beyond the top of stack..."
		 numMediatedSlots to: (self numSlotsOf: objOop) - 1 do:
			[:i|
			self storePointerUnchecked: i ofObject: copy withValue: nilObj]]