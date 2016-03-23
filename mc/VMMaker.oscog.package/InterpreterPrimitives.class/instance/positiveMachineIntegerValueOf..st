primitive support
positiveMachineIntegerValueOf: oop
	"Answer a value of an integer in address range, i.e up to the size of a machine word.
	The object may be either a positive SmallInteger or a LargePositiveInteger of size <= word size."
	<returnTypeC: #'unsigned long'>
	<inline: true> "only two callers & one is primitiveNewWithArg"
	| value bs ok |
	(objectMemory isIntegerObject: oop) ifTrue:
		[value := objectMemory integerValueOf: oop.
		 value < 0 ifTrue: [^self primitiveFail].
		^value].

	(objectMemory isNonIntegerImmediate: oop) ifTrue:
		[self primitiveFail.
		 ^0].

	ok := objectMemory
			isClassOfNonImm: oop
			equalTo: (objectMemory splObj: ClassLargePositiveInteger)
			compactClassIndex: ClassLargePositiveIntegerCompactIndex.
	ok ifFalse:
		[self primitiveFail.
		 ^0].
	bs := objectMemory numBytesOfBytes: oop.
	bs > (self sizeof: #'unsigned long') ifTrue:
		[self primitiveFail.
		 ^0].

	((self sizeof: #'unsigned long') = 8
	and: [bs > 4]) ifTrue:
		[^self cppIf: VMBIGENDIAN
			ifTrue:
				[    (objectMemory fetchByte: 0 ofObject: oop)
				 + ((objectMemory fetchByte: 1 ofObject: oop) <<  8)
				 + ((objectMemory fetchByte: 2 ofObject: oop) << 16)
				 + ((objectMemory fetchByte: 3 ofObject: oop) << 24)
				 + ((objectMemory fetchByte: 4 ofObject: oop) << 32)
				 + ((objectMemory fetchByte: 5 ofObject: oop) << 40)
				 + ((objectMemory fetchByte: 6 ofObject: oop) << 48)
				 + ((objectMemory fetchByte: 7 ofObject: oop) << 56)]
			ifFalse:
				[objectMemory fetchLong64: 0 ofObject: oop]]
		ifFalse:
			[^self cppIf: VMBIGENDIAN
				ifTrue:
					[    (objectMemory fetchByte: 0 ofObject: oop)
					 + ((objectMemory fetchByte: 1 ofObject: oop) <<  8)
					 + ((objectMemory fetchByte: 2 ofObject: oop) << 16)
					 + ((objectMemory fetchByte: 3 ofObject: oop) << 24)]
				ifFalse:
					[self cCoerceSimple: (objectMemory fetchLong32: 0 ofObject: oop) to: #'unsigned int']]