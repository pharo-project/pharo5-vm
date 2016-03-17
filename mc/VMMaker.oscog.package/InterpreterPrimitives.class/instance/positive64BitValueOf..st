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

	self cppIf: VMBIGENDIAN
		ifTrue:
			[value := 0.
			0 to: sz - 1 do: [:i |
				value := value + ((self cCoerce: (objectMemory fetchByte: i ofObject: oop) to: #usqLong) <<  (i*8))]]
		ifFalse:
			[sz > 4
				ifTrue: [value := self cCoerceSimple: (objectMemory fetchLong64: 0 ofObject: oop) to: #usqLong]
				ifFalse: [value := self cCoerceSimple: (objectMemory fetchLong32: 0 ofObject: oop) to: #'unsigned int'].].
	^value