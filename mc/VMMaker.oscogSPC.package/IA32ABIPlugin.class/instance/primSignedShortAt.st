primitives-accessing
primSignedShortAt
	"Answer the signed 32-bit integer starting at the given byte offset (little endian)."
	"<Alien> signedShortAt: index <Integer> ^<Integer>
		<primitive: 'primSignedShortAt' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr value valueOop |
	<export: true>
	<var: #value type: 'short '>

	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 0) - 1.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: 2 inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	value := self shortAt: addr.
	valueOop := interpreterProxy signed32BitIntegerFor: value.
	^interpreterProxy methodReturnValue: valueOop