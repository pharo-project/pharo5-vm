primitives
primitiveFFIIntegerAt
	"Answer a (signed or unsigned) n byte integer from the given byte offset
	 in the receiver, using the platform's endianness."
	| isSigned byteSize byteOffset rcvr addr value mask valueOop |
	<var: 'value' type: #usqLong>
	<var: 'mask' type: #usqLong>
	<export: true>
	<inline: false>
	isSigned := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 0).
	byteSize := interpreterProxy stackIntegerValue: 1.
	byteOffset := interpreterProxy stackIntegerValue: 2.
	rcvr := interpreterProxy stackObjectValue: 3.
	interpreterProxy failed ifTrue:[^0].
	(byteOffset > 0
	 and: [(byteSize between: 1 and: 8)
	 and: [(byteSize bitAnd: byteSize - 1) = 0 "a.k.a. isPowerOfTwo"]]) ifFalse:
		[^interpreterProxy primitiveFail].
	addr := self ffiAddressOf: rcvr startingAt: byteOffset size: byteSize.
	interpreterProxy failed ifTrue:[^0].
	byteSize <= 2
		ifTrue:
			[byteSize = 1
				ifTrue: [value := self cCoerceSimple: (interpreterProxy byteAt: addr) to: #'unsigned char']
				ifFalse: [value := self cCoerceSimple: (interpreterProxy shortAt: addr) to: #'unsigned short']]
		ifFalse:
			[byteSize = 4
				ifTrue: [value := self cCoerceSimple: (interpreterProxy long32At: addr) to: #'unsigned int']
				ifFalse: [value := interpreterProxy long64At: addr]].
	byteSize < BytesPerWord
		ifTrue:
			[isSigned ifTrue: "sign extend value"
				[mask := 1 asUnsignedLongLong << (byteSize * 8 - 1).
				value := (value bitAnd: mask-1) - (value bitAnd: mask)].
			 "note: byte/short (&long if BytesPerWord=8) never exceed SmallInteger range"
			 valueOop := interpreterProxy integerObjectOf: value]
		ifFalse: "general 64 bit integer; note these never fail"
			[isSigned
				ifTrue:
					[byteSize < 8 ifTrue: "sign extend value"
						[mask := 1 asUnsignedLongLong << (byteSize * 8 - 1).
						value := (value bitAnd: mask-1) - (value bitAnd: mask)].
					 valueOop := interpreterProxy signed64BitIntegerFor: value]
				ifFalse:[valueOop := interpreterProxy positive64BitIntegerFor: value]].
	^interpreterProxy pop: 4 thenPush: valueOop