bootstrap image
mapOldBehavior: oldObj toNewBehavior: newObj
	"Map the old format inst var's value to the new value.
	 In addition, for Character, make it immediate and remove its instance variable."
	newHeap
		storePointerUnchecked: InstanceSpecificationIndex
		ofObject: newObj
		withValue: (self newClassFormatFor: oldObj).
	oldObj = oldHeap classCharacter ifTrue:
		[InstanceSpecificationIndex + 1 to: (oldHeap numSlotsOf: oldObj) do:
			[:i| | var field |
			var := oldHeap fetchPointer: i ofObject: oldObj.
			((oldHeap fetchClassOf: var) = oldHeap classArray
			 and: [(oldHeap numSlotsOf: var) = 1
			 and: [field := oldHeap fetchPointer: 0 ofObject: var.
				(oldHeap fetchClassOf: field) = oldHeap classString
			 and: [(oldHeap lengthOf: field) = 5
			 and: [(oldHeap str: 'value'  n: (oldHeap firstIndexableField: field) cmp: 5) = 0]]]]) ifTrue:
				[newHeap
					storePointerUnchecked: i
					ofObject: newObj
					withValue: newHeap nilObject.
				 ^self]]]