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
				[(objectMemory fetchLong64: 0 ofObject: oop) byteSwap64]
			ifFalse:
				[objectMemory fetchLong64: 0 ofObject: oop]]
		ifFalse:
			[^self cppIf: VMBIGENDIAN
				ifTrue:
					[(self cCoerceSimple: (objectMemory fetchLong32: 0 ofObject: oop) to: #'unsigned int') byteSwap32]
				ifFalse:
					[self cCoerceSimple: (objectMemory fetchLong32: 0 ofObject: oop) to: #'unsigned int']]