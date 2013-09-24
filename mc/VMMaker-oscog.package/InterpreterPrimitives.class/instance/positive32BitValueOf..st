primitive support
positive32BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive SmallInteger or a four-byte LargePositiveInteger."

	| value ok |
	(objectMemory isIntegerObject: oop)
		ifTrue:
			[value := objectMemory integerValueOf: oop.
			value < 0 ifTrue: [self primitiveFail. value := 0].
			^value]
		ifFalse:
			[(objectMemory hasSpurMemoryManagerAPI
			  and: [objectMemory isImmediate: oop]) ifTrue:
				[self primitiveFail.
				 ^0]].

	ok := objectMemory isClassOfNonImm: oop
			equalTo: (objectMemory splObj: ClassLargePositiveInteger)
			compactClassIndex: ClassLargePositiveIntegerCompactIndex.
	(ok and: [(objectMemory lengthOf: oop) = 4]) ifFalse:
		[self primitiveFail.
		 ^0].
	^(objectMemory fetchByte: 0 ofObject: oop)
	+ ((objectMemory fetchByte: 1 ofObject: oop) <<  8)
	+ ((objectMemory fetchByte: 2 ofObject: oop) << 16)
	+ ((objectMemory fetchByte: 3 ofObject: oop) << 24)