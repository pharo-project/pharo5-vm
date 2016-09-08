primitives
primitiveFFIIntegerAt
	"Return a (signed or unsigned) n byte integer from the given byte offset."
	| isSigned byteSize byteOffset rcvr addr value mask |
	<export: true>
	<inline: false>
	isSigned := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 0).
	byteSize := interpreterProxy stackIntegerValue: 1.
	byteOffset := interpreterProxy stackIntegerValue: 2.
	rcvr := interpreterProxy stackObjectValue: 3.
	interpreterProxy failed ifTrue:[^0].
	(byteOffset > 0 and:[byteSize = 1 or:[byteSize = 2 or:[byteSize = 4]]])
		ifFalse:[^interpreterProxy primitiveFail].
	addr := self ffiAddressOf: rcvr startingAt: byteOffset size: byteSize.
	interpreterProxy failed ifTrue:[^0].
	byteSize < 4 ifTrue:[
		"short/byte"
		byteSize = 1 
			ifTrue:[value := interpreterProxy byteAt: addr]
			ifFalse:[	value := self cCode: '*((unsigned short int *) addr)' 
								inSmalltalk: [interpreterProxy shortAt: addr]].
		isSigned ifTrue:["sign extend value"
			mask := 1 << (byteSize * 8 - 1).
			value := (value bitAnd: mask-1) - (value bitAnd: mask)].
		"note: byte/short never exceed SmallInteger range"
		value := interpreterProxy integerObjectOf: value.
	] ifFalse:[
		"general 32 bit integer"
		value := interpreterProxy longAt: addr.
		isSigned
			ifTrue:[value := interpreterProxy signed32BitIntegerFor: value]
			ifFalse:[value := interpreterProxy positive32BitIntegerFor: value].
	].
	interpreterProxy pop: 4.
	^interpreterProxy push: value
