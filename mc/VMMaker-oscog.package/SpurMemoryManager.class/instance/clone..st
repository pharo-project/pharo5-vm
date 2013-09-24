allocation
clone: objOop
	| numSlots newObj |
	numSlots := self numSlotsOf: objOop.
	newObj := self allocateSlots: (self numSlotsOf: objOop)
					format: (self formatOf: objOop)
					classIndex: (self classIndexOf: objOop).
	(self isPointersNonImm: objOop)
		ifTrue:
			[0 to: numSlots - 1 do:
				[:i| | oop |
				oop := self fetchPointer: i ofObject: objOop.
				((self isNonImmediate: oop)
				 and: [self isForwarded: oop]) ifTrue:
					[oop := self followForwarded: oop].
				self storePointerUnchecked: i
					ofObject: newObj
					withValue: oop].
			((self isRemembered: objOop)
			 and: [self isYoung: newObj]) ifTrue:
				[scavenger remember: objOop.
				 self setIsRememberedOf: objOop to: true]]
		ifFalse:
			[0 to: numSlots - 1 do:
				[:i|
				self storePointerUnchecked: i
					ofObject: newObj
					withValue: (self fetchPointer: i ofObject: objOop)]].
	^newObj