primitive support
positiveMachineIntegerValueOf: oop
	"Answer a value of an integer in address range, i.e up to the size of a machine word.
	The object may be either a positive SmallInteger or a LargePositiveInteger of size <= word size."
	<returnTypeC: #'unsigned long'>
	| value bs ok |
	(self isIntegerObject: oop) ifTrue:
		[value := self integerValueOf: oop.
		 value < 0 ifTrue: [^self primitiveFail].
		^value].

	ok := self
			isClassOfNonImm: oop
			equalTo: (self splObj: ClassLargePositiveInteger)
			compactClassIndex: ClassLargePositiveIntegerCompactIndex.
	(ok and: [(bs := self lengthOf: oop) <= (self sizeof: #'unsigned long')]) ifFalse:
		[^self primitiveFail].

	((self sizeof: #'unsigned long') = 8
	and: [bs > 4]) ifTrue:
		[^  (self fetchByte: 0 ofObject: oop)
		 + ((self fetchByte: 1 ofObject: oop) <<  8)
		 + ((self fetchByte: 2 ofObject: oop) << 16)
		 + ((self fetchByte: 3 ofObject: oop) << 24)
		 + ((self fetchByte: 4 ofObject: oop) << 32)
		 + ((self fetchByte: 5 ofObject: oop) << 40)
		 + ((self fetchByte: 6 ofObject: oop) << 48)
		 + ((self fetchByte: 7 ofObject: oop) << 56)].

	^  (self fetchByte: 0 ofObject: oop)
	+ ((self fetchByte: 1 ofObject: oop) <<  8)
	+ ((self fetchByte: 2 ofObject: oop) << 16)
	+ ((self fetchByte: 3 ofObject: oop) << 24)