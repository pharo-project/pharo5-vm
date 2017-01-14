primitives-accessing
primFloatAt
	"Answer the 32-bit float starting at the given byte offset (little endian)."
	"<Alien> floatAt: index <Integer> ^<Float>
		<primitive: 'primFloatAt' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr floatValue |
	<export: true>
	<var: #floatValue type: #float>

	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 0) - 1.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: 4 inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	self mem: (self addressOf: floatValue) cp: addr y: (self sizeof: floatValue).
	interpreterProxy pop: 2.
	^interpreterProxy pushFloat: floatValue