primitives
primitiveFFIIntegerAtPut
	"Store a (signed or unsigned) n byte integer at the given byte offset."
	| isSigned byteSize byteOffset rcvr addr value max valueOop |
	<export: true>
	<inline: false>
	isSigned := interpreterProxy booleanValueOf: (interpreterProxy stackValue: 0).
	byteSize := interpreterProxy stackIntegerValue: 1.
	valueOop := interpreterProxy stackValue: 2.
	byteOffset := interpreterProxy stackIntegerValue: 3.
	rcvr := interpreterProxy stackObjectValue: 4.
	interpreterProxy failed ifTrue:[^0].
	(byteOffset > 0 and:[byteSize = 1 or:[byteSize = 2 or:[byteSize = 4]]])
		ifFalse:[^interpreterProxy primitiveFail].
	addr := self ffiAddressOf: rcvr startingAt: byteOffset size: byteSize.
	interpreterProxy failed ifTrue:[^0].
	isSigned 
		ifTrue:[value := interpreterProxy signed32BitValueOf: valueOop]
		ifFalse:[value := interpreterProxy positive32BitValueOf: valueOop].
	interpreterProxy failed ifTrue:[^0].
	byteSize < 4 ifTrue:[
		isSigned ifTrue:[
			max := 1 << (8 * byteSize - 1).
			value >= max ifTrue:[^interpreterProxy primitiveFail].
			value < (0 - max) ifTrue:[^interpreterProxy primitiveFail].
		] ifFalse:[
			value >= (1 << (8*byteSize)) ifTrue:[^interpreterProxy primitiveFail].
		].
		"short/byte"
		byteSize = 1 
			ifTrue:[interpreterProxy byteAt: addr put: value]
			ifFalse:[	self cCode: '*((short int *) addr) = value' 
						inSmalltalk: [interpreterProxy shortAt: addr put: value]].
	] ifFalse:[interpreterProxy longAt: addr put: value].
	interpreterProxy pop: 5.
	^interpreterProxy push: valueOop.