become implementation
inPlaceBecome: obj1 and: obj2 copyHashFlag: copyHashFlag
	"Do become in place by swapping object contents."
	| headerTemp temp1 temp2 o1HasYoung o2HasYoung |
	<var: 'headerTemp' type: #usqLong>
	self assert: (self numSlotsOf: obj1) = (self numSlotsOf: obj2).
	"swap headers, but swapping headers swaps remembered bits;
	 these need to be unswapped."
	temp1 := self isRemembered: obj1.
	temp2 := self isRemembered: obj2.
	headerTemp := self longLongAt: obj1.
	self longLongAt: obj1 put: (self longLongAt: obj2).
	self longLongAt: obj2 put: headerTemp.
	self setIsRememberedOf: obj1 to: temp1.
	self setIsRememberedOf: obj2 to: temp2.
	"swapping headers swaps hash; if !copyHashFlagundo hash copy"
	copyHashFlag ifFalse:
		[temp1 := self rawHashBitsOf: obj1.
		 self setHashBitsOf: obj1 to: (self rawHashBitsOf: obj2).
		 self setHashBitsOf: obj2 to: temp1].
	o1HasYoung := o2HasYoung := false.
	0 to: (self numSlotsOf: obj1) - 1 do:
		[:i|
		temp1 := self fetchPointer: i ofObject: obj1.
		temp2 := self fetchPointer: i ofObject: obj2.
		self storePointerUnchecked: i
			ofObject: obj1
			withValue: temp2.
		self storePointerUnchecked: i
			ofObject: obj2
			withValue: temp1.
		((self isNonImmediate: temp2) and: [self isYoung: temp2]) ifTrue:
			[o1HasYoung := true].
		((self isNonImmediate: temp1) and: [self isYoung: temp1]) ifTrue:
			[o2HasYoung := true]].
	(self isYoung: obj1) ifFalse:
		[o1HasYoung ifTrue:
			[self possibleRootStoreInto: obj1]].
	(self isYoung: obj2) ifFalse:
		[o2HasYoung ifTrue:
			[self possibleRootStoreInto: obj2]]