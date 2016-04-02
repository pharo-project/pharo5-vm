primitive support
magnitude64BitValueOf: oop
	"Convert the given object into an integer value.
	The object may be either a positive SmallInteger or an eight-byte LargeInteger."
	| sz value ok smallIntValue |
	<returnTypeC: #usqLong>
	<var: #value type: #usqLong>

	(objectMemory isIntegerObject: oop) ifTrue:
		[smallIntValue := (objectMemory integerValueOf: oop).
		smallIntValue < 0 ifTrue: [smallIntValue := 0 - smallIntValue].
		^self cCoerce: smallIntValue to: #usqLong].

	(objectMemory isNonIntegerImmediate: oop) ifTrue:
		[self primitiveFail.
		 ^0].

	ok := objectMemory isClassOfNonImm: oop
					equalTo: (objectMemory splObj: ClassLargePositiveInteger)
					compactClassIndex: ClassLargePositiveIntegerCompactIndex.
	ok
		ifFalse:
			[ok := objectMemory isClassOfNonImm: oop
							equalTo: (objectMemory splObj: ClassLargeNegativeInteger)
							compactClassIndex: ClassLargeNegativeIntegerCompactIndex.
			ok ifFalse:
				[self primitiveFail.
				 ^0]].
	sz := objectMemory numBytesOfBytes: oop.
	sz > (self sizeof: #sqLong) ifTrue:
		[self primitiveFail.
		 ^0].

	self cppIf: VMBIGENDIAN
		ifTrue:
			[sz > 4
				ifTrue: [value := (self cCoerceSimple: (objectMemory fetchLong64: 0 ofObject: oop) to: #usqLong) byteSwap64]
				ifFalse: [value := (self cCoerceSimple: (objectMemory fetchLong32: 0 ofObject: oop) to: #'unsigned int') byteSwap32].]
		ifFalse:
			[sz > 4
				ifTrue: [value := self cCoerceSimple: (objectMemory fetchLong64: 0 ofObject: oop) to: #usqLong]
				ifFalse: [value := self cCoerceSimple: (objectMemory fetchLong32: 0 ofObject: oop) to: #'unsigned int'].].
	^value