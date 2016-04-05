primitive support
signed64BitValueOf: oop
	"Convert the given object into an integer value.
	 The object may be either a positive SmallInteger or a eight-byte LargeInteger."
	| sz value negative ok magnitude |
	<inline: false>
	<returnTypeC: #sqLong>
	<var: #value type: #sqLong>
	<var: #magnitude type: #usqLong>
	(objectMemory isIntegerObject: oop) ifTrue:
		[^self cCoerce: (objectMemory integerValueOf: oop) to: #sqLong].

	(objectMemory isNonIntegerImmediate: oop) ifTrue:
		[self primitiveFail.
		 ^0].

	ok := objectMemory isClassOfNonImm: oop
					equalTo: (objectMemory splObj: ClassLargePositiveInteger)
					compactClassIndex: ClassLargePositiveIntegerCompactIndex.
	ok
		ifTrue: [negative := false]
		ifFalse:
			[negative := true.
			 ok := objectMemory isClassOfNonImm: oop
							equalTo: (objectMemory splObj: ClassLargeNegativeInteger)
							compactClassIndex: ClassLargeNegativeIntegerCompactIndex.
			ok ifFalse:
				[self primitiveFail.
				 ^0]].
	sz := objectMemory numBytesOfBytes: oop.
	sz > (self sizeof: #sqLong) ifTrue:
		[self primitiveFail.
		 ^0].

	"self cppIf: SPURVM
		ifTrue:
			[""Memory is 8 byte aligned in Spur and oversized bytes are set to zero, so we can safely fetch 8 bytes""
			magnitude := objectMemory byteSwapped64IfBigEndian: (objectMemory fetchLong64: 0 ofObject: oop)]
		ifFalse:
			["sz > 4
				ifTrue: [magnitude := objectMemory byteSwapped64IfBigEndian: (objectMemory fetchLong64: 0 ofObject: oop)]
				ifFalse: [magnitude := self cCoerceSimple: (objectMemory byteSwapped32IfBigEndian: (objectMemory fetchLong32: 0 ofObject: oop)) to: #'unsigned int']"]".

	(negative
		ifTrue: [magnitude > 16r8000000000000000]
		ifFalse: [magnitude >= 16r8000000000000000])
			ifTrue: [self primitiveFail.
				^0].
	negative
		ifTrue: [value := 0 - magnitude]
		ifFalse: [value := magnitude].
	^value