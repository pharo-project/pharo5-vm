become implementation
inPlaceBecome: obj1 and: obj2 copyHashFlag: copyHashFlag
	"Do become in place by swapping object contents."
	| headerTemp temp1 temp2 o1HasYoung o2HasYoung fmt |
	self assert: (self numSlotsOf: obj1) = (self numSlotsOf: obj2).
	"swap headers, but swapping headers swaps remembered bits;
	 these need to be unswapped."
	temp1 := self isRemembered: obj1.
	temp2 := self isRemembered: obj2.
	headerTemp := self long64At: obj1.
	self long64At: obj1 put: (self long64At: obj2).
	self long64At: obj2 put: headerTemp.
	self setIsRememberedOf: obj1 to: temp1.
	self setIsRememberedOf: obj2 to: temp2.
	"swapping headers swaps hash; if !copyHashFlag undo hash copy"
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
		(self isYoung: temp2) ifTrue:
			[o1HasYoung := true].
		(self isYoung: temp1) ifTrue:
			[o2HasYoung := true]].
	(self isOldObject: obj1) ifTrue:
		[fmt := self formatOf: obj1.
		 (o1HasYoung and: [(self isPureBitsFormat: fmt) not]) ifTrue:
			[self possibleRootStoreInto: obj1]].
	(self isOldObject: obj2) ifTrue:
		[fmt := self formatOf: obj2.
		 (o2HasYoung and: [(self isPureBitsFormat: fmt) not]) ifTrue:
			[self possibleRootStoreInto: obj2]]