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

	self cppIf: VMBIGENDIAN
		ifTrue:
			[magnitude := objectMemory fetchByte: sz - 1 ofObject: oop.
			 sz - 2 to: 0 by: -1 do: [:i |
				magnitude := magnitude << 8 + (objectMemory fetchByte: i ofObject: oop)]]
		ifFalse:
			[magnitude := sz > 4
						ifTrue: [objectMemory fetchLong64: 0 ofObject: oop]
						ifFalse: [(objectMemory fetchLong32: 0 ofObject: oop) asUnsignedInteger]].

	(negative
		ifTrue: [magnitude > 16r8000000000000000]
		ifFalse: [magnitude >= 16r8000000000000000])
			ifTrue: [self primitiveFail.
				^0].
	negative
		ifTrue: [value := 0 - magnitude]
		ifFalse: [value := magnitude].
	^value