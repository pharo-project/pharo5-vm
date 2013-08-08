primitives
primitiveFFIFloatAtPut
	"Return a (signed or unsigned) n byte integer from the given byte offset."
	| byteOffset rcvr addr floatValue floatOop |
	<export: true>
	<inline: false>
	<var: #floatValue type:'float '>
	floatOop := interpreterProxy stackValue: 0.
	(interpreterProxy isIntegerObject: floatOop)
		ifTrue:[floatValue := self cCoerce: (interpreterProxy integerValueOf: floatOop) to:'float']
		ifFalse:[floatValue := self cCoerce: (interpreterProxy floatValueOf: floatOop) to:'float'].
	byteOffset := interpreterProxy stackIntegerValue: 1.
	rcvr := interpreterProxy stackObjectValue: 2.
	interpreterProxy failed ifTrue:[^0].
	addr := self ffiAddressOf: rcvr startingAt: byteOffset size: 4.
	interpreterProxy failed ifTrue:[^0].
	self cCode:'((int*)addr)[0] = ((int*)(&floatValue))[0]'.
	interpreterProxy pop: 3 thenPush: floatOop