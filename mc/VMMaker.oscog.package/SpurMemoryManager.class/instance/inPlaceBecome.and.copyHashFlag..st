become implementation
inPlaceBecome: obj1 and: obj2 copyHashFlag: copyHashFlag
	<inline: #never> "in an effort to fix a compiler bug with two-way become post r3427"
	"Do become in place by swapping object contents."
	| o1HasYoung o2HasYoung fmt |
	self assert: (self numSlotsOf: obj1) = (self numSlotsOf: obj2).
	self assert: ((self rawHashBitsOf: obj1) = 0
				 or: [(self classOrNilAtIndex: (self rawHashBitsOf: obj1)) ~= obj1]).
	self assert: ((self rawHashBitsOf: obj2) = 0
				 or: [(self classOrNilAtIndex: (self rawHashBitsOf: obj2)) ~= obj2]).
	"swap headers, but swapping headers swaps remembered bits and hashes;
	 remembered bits must be unswapped and hashes may be unswapped if
	 copyHash is false."
	false
		ifTrue: [self naiveSwapHeaders: obj1 and: obj2 copyHashFlag: copyHashFlag]
		ifFalse: [self cleverSwapHeaders: obj1 and: obj2 copyHashFlag: copyHashFlag].
	o1HasYoung := o2HasYoung := false.
	0 to: (self numSlotsOf: obj1) - 1 do:
		[:i| | temp1 temp2 |
		temp1 := self fetchPointer: i ofObject: obj1.
		temp2 := self fetchPointer: i ofObject: obj2.
		self storePointerUnchecked: i ofObject: obj1 withValue: temp2.
		self storePointerUnchecked: i ofObject: obj2 withValue: temp1.
		(self isYoung: temp2) ifTrue:
			[o1HasYoung := true].
		(self isYoung: temp1) ifTrue:
			[o2HasYoung := true]].
	(o1HasYoung and: [self isOldObject: obj1]) ifTrue:
		[fmt := self formatOf: obj1.
		 (self isPureBitsFormat: fmt) ifFalse:
			[self possibleRootStoreInto: obj1]].
	(o2HasYoung and: [self isOldObject: obj2]) ifTrue:
		[fmt := self formatOf: obj2.
		 (self isPureBitsFormat: fmt) ifFalse:
			[self possibleRootStoreInto: obj2]]