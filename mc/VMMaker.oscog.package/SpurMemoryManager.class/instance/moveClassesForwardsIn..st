image segment in/out
moveClassesForwardsIn: arrayOfObjects
	"This is part of storeImageSegmentInto:outPointers:roots:.
	 Both to expand the max size of segment and to reduce the length of the
	 load-time pass that adds classes to the class table, move classes to the
	 front of arrayOfObjects, leaving the root array as the first element."
	| there |
	there := 0. "if > 0, this is the index of the first non-class past the first element."
	1 to: (self numSlotsOf: arrayOfObjects) - 1 do:
		[:here| | objOop hash tempObjOop |
		 objOop := self fetchPointer: here ofObject: arrayOfObjects.
		 hash := self rawHashBitsOf: objOop.
		 (hash > self lastClassIndexPun and: [(self classOrNilAtIndex: hash) = objOop])
			ifTrue:
				[there > 0 ifTrue: "if there is zero we're in a run of classes at the start so don't move"
					[tempObjOop := self fetchPointer: there ofObject: arrayOfObjects.
					 self storePointerUnchecked: there ofObject: arrayOfObjects withValue: objOop.
					 self storePointerUnchecked: here ofObject: arrayOfObjects withValue: tempObjOop.
					 there := there + 1]]
			ifFalse:
				[there = 0 ifTrue:
					[there := here]]]