primitives
primitiveFFIDoubleAt
	"Return a (signed or unsigned) n byte integer from the given byte offset."
	| byteOffset rcvr addr floatValue |
	<export: true>
	<inline: false>
	<var: #floatValue type: #double>
	byteOffset := interpreterProxy stackIntegerValue: 0.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:[^0].
	addr := self ffiAddressOf: rcvr startingAt: byteOffset size: 8.
	interpreterProxy failed ifTrue:[^0].
	self mem: (self addressOf: floatValue) cp: addr y: (self sizeof: floatValue).
	interpreterProxy pop: 2.
	^interpreterProxy pushFloat: floatValue
