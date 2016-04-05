primitive support
signedMachineIntegerValueOf: oop
	"Answer a signed value of an integer up to the size of a machine word.
	The object may be either a positive SmallInteger or a LargeInteger of size <= word size."
	<returnTypeC: #'long'>
	| negative ok bs value limit magnitude |
	<var: #value type: #long>
	<var: #magnitude type: #usqInt>
	<var: #limit type: #usqInt>
	(objectMemory isIntegerObject: oop) ifTrue:
		[^objectMemory integerValueOf: oop].

	(objectMemory isNonIntegerImmediate: oop) ifTrue:
		[^self primitiveFail].

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
			ok ifFalse: [^self primitiveFail]].
	bs := objectMemory numBytesOf: oop.
	bs > (self sizeof: #'unsigned long') ifTrue:
		[^self primitiveFail].

	"self cppIf: SPURVM
		ifTrue:
			[""Memory is 8 byte aligned in Spur and oversized bytes are set to zero, so we can safely fetch 8 bytes""
			magnitude := objectMemory byteSwapped64IfBigEndian: (objectMemory fetchLong64: 0 ofObject: oop)]
		ifFalse:
			["((self sizeof: #'unsigned long') = 8
			and: [bs > 4])
				ifTrue:
					[magnitude := objectMemory byteSwapped64IfBigEndian: (objectMemory fetchLong64: 0 ofObject: oop)]
				ifFalse:
					[magnitude := self cCoerceSimple: (objectMemory byteSwapped32IfBigEndian: (objectMemory fetchLong32: 0 ofObject: oop)) to: #'unsigned int']"]".

	limit := 1 asUnsignedInteger << ((self sizeof: #usqInt) * 8 - 1).
	(negative
		ifTrue: [magnitude > limit]
		ifFalse: [magnitude >= limit])
			ifTrue: [self primitiveFail.
				^0].
	negative
		ifTrue: [value := 0 - magnitude]
		ifFalse: [value := magnitude].
	^value