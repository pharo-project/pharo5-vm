primitives-accessing
primUnsignedLongAt
	"Answer the unsigned 32-bit integer starting at the given byte offset (little endian)."
	"<Alien> unsignedLongAt: index <Integer> ^<Integer>
		<primitive: 'primUnsignedLongAt' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr value valueOop |
	<export: true>

	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 0) - 1.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: 4 inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	value := self long32At: addr.
	valueOop := interpreterProxy positive32BitIntegerFor: value.
	^interpreterProxy methodReturnValue: valueOop