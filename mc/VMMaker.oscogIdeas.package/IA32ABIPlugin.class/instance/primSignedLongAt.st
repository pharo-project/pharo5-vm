primitives-accessing
primSignedLongAt
	"Answer the signed 32-bit integer starting at the given byte offset (little endian)."
	"<Alien> signedLongAt: index <Integer> ^<Integer>
		<primitive: 'primSignedLongAt' error: errorCode module: 'IA32ABI'>"
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
	valueOop := interpreterProxy signed32BitIntegerFor: value.
	^interpreterProxy methodReturnValue: valueOop