become implementation
doBecome: obj1 and: obj2 copyHash: copyHashFlag
	"Inner dispatch for two-way become.
	 N.B. At least in current two-way become use copyHashFlag is false."
	| o1ClassIndex o2ClassIndex |
	"in-lined
			classIndex := (self isInClassTable: obj) ifTrue: [self rawHashBitsOf: obj] ifFalse: [0]
	 for speed."
	o1ClassIndex := self rawHashBitsOf: obj1.
	(o1ClassIndex ~= 0 and: [(self classAtIndex: o1ClassIndex) ~= obj1]) ifTrue:
		[o1ClassIndex := 0].
	o2ClassIndex := self rawHashBitsOf: obj2.
	(o2ClassIndex ~= 0 and: [(self classAtIndex: o2ClassIndex) ~= obj2]) ifTrue:
		[o2ClassIndex := 0].

	"Refuse to do an in-place become on classes since their being
	 forwarded is used in the flush method cache implementations."
	((self numSlotsOf: obj1) = (self numSlotsOf: obj2)
	 and: [o1ClassIndex = 0
	 and: [o2ClassIndex = 0]]) ifTrue:
		[self inPlaceBecome: obj1 and: obj2 copyHashFlag: copyHashFlag.
		 ^self].
	self outOfPlaceBecome: obj1 and: obj2 copyHashFlag: copyHashFlag.
	"if copyHashFlag then nothing changes, since hashes were also swapped."
	copyHashFlag ifTrue:
		[^self].
	"if copyHash is false then the classTable entries must be updated.
	 We leave the following until postBecomeScanClassTable:, but must
	 swap the forwarders if two active classes have been becommed,
	 and assign hashes if not."
	o1ClassIndex ~= 0
		ifTrue:
			[o2ClassIndex ~= 0
				ifTrue:
					[self classAtIndex: o1ClassIndex put: obj2.
					 self classAtIndex: o2ClassIndex put: obj1]
				ifFalse: "o2 wasn't in the table; set its hash"
					[| newObj2 |
					 newObj2 := self followForwarded: obj1.
					 self assert: (self rawHashBitsOf: newObj2) = 0.
					 self setHashBitsOf: newObj2 to: o1ClassIndex]]
		ifFalse:
			[o2ClassIndex ~= 0 ifTrue: "o1 wasn't in the table; set its hash"
				[| newObj1 |
				 newObj1 := self followForwarded: obj2.
				 self assert: (self rawHashBitsOf: newObj1) = 0.
				 self setHashBitsOf: newObj1 to: o2ClassIndex]]