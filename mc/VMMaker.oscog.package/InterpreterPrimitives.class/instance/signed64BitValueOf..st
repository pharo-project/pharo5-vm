primitive support
signed64BitValueOf: oop
	"Convert the given object into an integer value.
	 The object may be either a positive SmallInteger or a eight-byte LargeInteger."
	| sz value negative ok |
	<inline: false>
	<returnTypeC: #sqLong>
	<var: #value type: #sqLong>
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
			[value := objectMemory fetchByte: sz - 1 ofObject: oop.
			 sz - 2 to: 0 by: -1 do: [:i |
				value := value << 8 + (objectMemory fetchByte: i ofObject: oop)]]
		ifFalse:
			[value := sz > 4
						ifTrue: [objectMemory fetchLong64: 0 ofObject: oop]
						ifFalse: [objectMemory fetchLong32: 0 ofObject: oop]].
	"Filter out values out of range for the signed interpretation such as
	16rFFFFFFFF... (positive w/ bit 64 set) and -16rFFFFFFFF... (negative w/ bit
	64 set). Since the sign is implicit in the class we require that the high bit of
	the magnitude is not set which is a simple test here.  Note that we have to
	handle the most negative 64-bit value -9223372036854775808 specially."
	self cCode: []
		inSmalltalk:
			[(value anyMask: 16r8000000000000000) ifTrue:
				[value := value - 16r10000000000000000]].
	value < 0 ifTrue:
		[self cCode:
			[self assert: (self sizeof: value) == 8.
			 self assert: (self sizeof: value << 1) == 8].
		"Don't fail for -9223372036854775808/-16r8000000000000000.
		 Alas the simple (negative and: [value - 1 > 0]) isn't adequate since in C the result of signed integer
		 overflow is undefined and hence under optimization this may fail.  The shift, however, is well-defined."
		 (negative and: [0 = (self cCode: [value << 1]
									inSmalltalk: [value << 1 bitAnd: (1 << 64) - 1])]) ifTrue: 
			[^value].
		 self primitiveFail.
		 ^0].
	^negative
		ifTrue:[0 - value]
		ifFalse:[value]