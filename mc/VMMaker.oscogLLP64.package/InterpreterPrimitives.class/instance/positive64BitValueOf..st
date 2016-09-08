primitive support
positive64BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive SmallInteger or an eight-byte LargePositiveInteger."

	<returnTypeC: #usqLong>
	| sz value ok |
	<var: #value type: #usqLong>
	(objectMemory isIntegerObject: oop) ifTrue:
		[(objectMemory integerValueOf: oop) < 0 ifTrue:
			[^self primitiveFail].
		 ^objectMemory integerValueOf: oop].

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
	sz > (self sizeof: #sqLong) ifTrue:
		[self primitiveFail.
		 ^0].

	"self cppIf: SPURVM
		ifTrue:
			[""Memory is 8 byte aligned in Spur and oversized bytes are set to zero, so we can safely fetch 8 bytes""
			value := objectMemory byteSwapped64IfBigEndian: (objectMemory fetchLong64: 0 ofObject: oop)]
		ifFalse:
			["sz > 4
				ifTrue: [value := objectMemory byteSwapped64IfBigEndian: (objectMemory fetchLong64: 0 ofObject: oop)]
				ifFalse: [value := self cCoerceSimple: (objectMemory byteSwapped32IfBigEndian: (objectMemory fetchLong32: 0 ofObject: oop)) to: #'unsigned int']"]".
	^value