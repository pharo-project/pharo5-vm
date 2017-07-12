allocation
cloneInOldSpace: objOop forPinning: forPinning
	<inline: false>
	| numSlots fmt newObj hash |
	numSlots := self numSlotsOf: objOop.
	fmt := self formatOf: objOop.
	
	forPinning
		ifTrue:
			[newObj := self allocateSlotsForPinningInOldSpace: numSlots
							bytes: (self objectBytesForSlots: numSlots)
							format: fmt
							classIndex: (self classIndexOf: objOop)]
		ifFalse:
			[newObj := self allocateSlotsInOldSpace: numSlots
							bytes: (self objectBytesForSlots: numSlots)
							format: fmt
							classIndex: (self classIndexOf: objOop)].
	newObj ifNil:
		[^0].
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
			hasYoung ifTrue:
				[scavenger remember: newObj]]
		ifFalse:
			[0 to: numSlots - 1 do:
				[:i|
				self storePointerUnchecked: i
					ofObject: newObj
					withValue: (self fetchPointer: i ofObject: objOop)].
			 fmt >= self firstCompiledMethodFormat ifTrue:
				[coInterpreter maybeFixClonedCompiledMethod: newObj.
				 ((self isYoungObject: objOop) or: [self isRemembered: objOop]) ifTrue:
					[scavenger remember: newObj]]].
	(hash := self rawHashBitsOf: objOop) ~= 0 ifTrue:
		[self setHashBitsOf: newObj to: hash].
	^newObj