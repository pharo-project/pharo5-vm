primitives-accessing
primSignedWordAt
	"Answer the signed word starting at the given byte offset (little endian)."
	"<Alien> signedWordAt: index <Integer> ^<Integer>
		<primitive: 'primSignedWordAt' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr value valueOop |
	<export: true>

	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 0) - 1.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: interpreterProxy bytesPerOop inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	value := self longAt: addr.
	valueOop := interpreterProxy signedMachineIntegerValueOf: value.
	^interpreterProxy methodReturnValue: valueOop