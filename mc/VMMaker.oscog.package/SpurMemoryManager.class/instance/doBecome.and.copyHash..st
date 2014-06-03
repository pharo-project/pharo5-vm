become implementation
doBecome: obj1 and: obj2 copyHash: copyHashFlag
	"Inner dispatch for two-way become"
	| o1ClassIndex o2ClassIndex |
	copyHashFlag ifFalse:
		["in-lined
			classIndex := (self isInClassTable: obj) ifTrue: [self rawHashBitsOf: obj] ifFalse: [0]
		 for speed."
		 o1ClassIndex := self rawHashBitsOf: obj1.
		 (o1ClassIndex ~= 0 and: [(self classAtIndex: o1ClassIndex) ~= obj1]) ifTrue:
			[o1ClassIndex := 0].
		 o2ClassIndex := self rawHashBitsOf: obj2.
		 (o2ClassIndex ~= 0 and: [(self classAtIndex: o2ClassIndex) ~= obj2]) ifTrue:
			[o2ClassIndex := 0]].
	(self numSlotsOf: obj1) = (self numSlotsOf: obj2)
		ifTrue:
			[self inPlaceBecome: obj1 and: obj2 copyHashFlag: copyHashFlag]
		ifFalse:
			[self outOfPlaceBecome: obj1 and: obj2 copyHashFlag: copyHashFlag].
	"if copyHashFlag then nothing changes, since hashes were also swapped."
	copyHashFlag ifTrue:
		[^self].
	"if copyHash is false then the classTable entries must be updated."
	o1ClassIndex ~= 0
		ifTrue:
			[o2ClassIndex ~= 0
				ifTrue: "both were in the table; just swap entries"
					[| tmp |
					 tmp := self classAtIndex: o1ClassIndex.
					 self classAtIndex: o1ClassIndex put: obj2.
					 self classAtIndex: o2ClassIndex put: tmp]
				ifFalse: "o2 wasn't in the table; put it there"
					[| newObj2 |
					 newObj2 := self followForwarded: obj1.
					 self assert: (self rawHashBitsOf: newObj2) = 0.
					 self setHashBitsOf: newObj2 to: o1ClassIndex.
					 self classAtIndex: o1ClassIndex put: newObj2]]
		ifFalse:
			[o2ClassIndex ~= 0 ifTrue:
				[| newObj1 |
				 newObj1 := self followForwarded: obj2.
				 self assert: (self rawHashBitsOf: newObj1) = 0.
				 self setHashBitsOf: newObj1 to: o2ClassIndex.
				 self classAtIndex: o2ClassIndex put: newObj1]]