primitives
primitiveFFIIntegerAtPut
	"Store a (signed or unsigned) n byte integer at the given byte offset
	 in the receiver, using the platform's endianness."
	| isSigned byteSize byteOffset rcvr addr value max valueOop |
	<var: 'value' type: #sqLong>
	<var: 'max' type: #sqLong>
	<export: true>
	<inline: false>
	isSigned := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 0).
	byteSize := interpreterProxy stackIntegerValue: 1.
	valueOop := interpreterProxy stackValue: 2.
	byteOffset := interpreterProxy stackIntegerValue: 3.
	rcvr := interpreterProxy stackObjectValue: 4.
	interpreterProxy failed ifTrue:[^0].
	(byteOffset > 0
	 and: [(byteSize between: 1 and: 8)
	 and: [(byteSize bitAnd: byteSize - 1) = 0 "a.k.a. isPowerOfTwo"]]) ifFalse:
		[^interpreterProxy primitiveFail].
	addr := self ffiAddressOf: rcvr startingAt: byteOffset size: byteSize.
	interpreterProxy failed ifTrue:[^0].
	isSigned 
		ifTrue:[value := interpreterProxy signed64BitValueOf: valueOop]
		ifFalse:[value := interpreterProxy positive64BitValueOf: valueOop].
	interpreterProxy failed ifTrue:[^0].
	byteSize < 8 ifTrue:
		[isSigned
			ifTrue:
				[max := 1 asUnsignedLongLong << (8 * byteSize - 1).
				(value >= (0 - max) and: [value < max]) ifFalse: [^interpreterProxy primitiveFail]]
			ifFalse:
				[value asUnsignedLongLong < (1 asUnsignedLongLong << (8 * byteSize)) ifFalse: [^interpreterProxy primitiveFail]]].
	byteSize <= 2
		ifTrue:
			[byteSize = 1
				ifTrue: [interpreterProxy byteAt: addr put: value]
				ifFalse: [interpreterProxy shortAt: addr put: value]]
		ifFalse:
			[byteSize = 4
				ifTrue: [interpreterProxy long32At: addr put: value]
				ifFalse: [interpreterProxy long64At: addr put: value]].
	^interpreterProxy pop: 5 thenPush: valueOop