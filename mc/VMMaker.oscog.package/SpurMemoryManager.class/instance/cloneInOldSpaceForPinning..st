allocation
cloneInOldSpaceForPinning: objOop
	| numSlots fmt newObj |
	numSlots := self numSlotsOf: objOop.
	fmt := self formatOf: objOop.
	
	newObj := self allocateSlotsForPinningInOldSpace: numSlots
					bytes: (self objectBytesForSlots: numSlots)
					format: fmt
					classIndex: (self classIndexOf: objOop).
	(self isPointersFormat: fmt)
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
				[scavenger remember: newObj]]
		ifFalse:
			[0 to: numSlots - 1 do:
				[:i|
				self storePointerUnchecked: i
					ofObject: newObj
					withValue: (self fetchPointer: i ofObject: objOop)].
			 fmt >= self firstCompiledMethodFormat ifTrue:
				[coInterpreter maybeFixClonedCompiledMethod: newObj.
				 ((self isOldObject: newObj)
				  and: [(self isYoungObject: objOop) or: [self isRemembered: objOop]]) ifTrue:
					[scavenger remember: newObj]]].
	^newObj