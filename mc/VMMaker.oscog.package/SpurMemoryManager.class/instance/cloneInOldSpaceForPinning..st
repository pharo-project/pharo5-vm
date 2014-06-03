allocation
cloneInOldSpaceForPinning: objOop
	| numSlots newObj |
	numSlots := self numSlotsOf: objOop.
	
	newObj := self allocateSlotsForPinningInOldSpace: numSlots
					bytes: (self objectBytesForSlots: numSlots)
					format: (self formatOf: objOop)
					classIndex: (self classIndexOf: objOop).
	(self isPointersNonImm: objOop)
		ifTrue:
			[| hasYoung |
			 hasYoung := false.
			 0 to: numSlots - 1 do:
				[:i| | oop |
				oop := self fetchPointer: i ofObject: objOop.
				((self isNonImmediate: oop)
				 and: [self isForwarded: oop]) ifTrue:
					[oop := self followForwarded: oop].
				((self isNonImmediate: oop)
				 and: [self isYoungObject: oop]) ifTrue:
					[hasYoung := true].
				self storePointerUnchecked: i
					ofObject: newObj
					withValue: oop].
			(hasYoung
			 and: [(self isYoungObject: newObj) not]) ifTrue:
				[scavenger remember: newObj.
				 self setIsRememberedOf: newObj to: true]]
		ifFalse:
			[0 to: numSlots - 1 do:
				[:i|
				self storePointerUnchecked: i
					ofObject: newObj
					withValue: (self fetchPointer: i ofObject: objOop)]].
	^newObj