primitive support
positive32BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive SmallInteger or a four-byte LargePositiveInteger."
	<returnTypeC: #usqInt>
	| value ok sz |
	(objectMemory isIntegerObject: oop) ifTrue:
		[value := objectMemory integerValueOf: oop.
		 (value < 0
		  or: [objectMemory wordSize > 4
		  and: [self cCode: [(self cCoerceSimple: value to: #'unsigned int') ~= value]
					inSmalltalk: [value >> 32 ~= 0]]]) ifTrue:
			[self primitiveFail. value := 0].
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
	sz := objectMemory numBytesOfBytes: oop.
	sz > 4 ifTrue:
		[self primitiveFail.
		 ^0].
	^self cppIf: VMBIGENDIAN
		ifTrue:
			[   (objectMemory fetchByte: 0 ofObject: oop)
			+ ((objectMemory fetchByte: 1 ofObject: oop) <<  8)
			+ ((objectMemory fetchByte: 2 ofObject: oop) << 16)
			+ ((objectMemory fetchByte: 3 ofObject: oop) << 24)]
		ifFalse:
			[objectMemory fetchLong32: 0 ofObject: oop]