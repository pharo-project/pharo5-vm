primitives-accessing
primUnsignedWordAtPut
	"Store an unsigned integer into 32 bits starting at the given byte offset (little endian)."
	"<Alien> unsignedWordAt: index <Integer> put: value <Integer> ^<Integer>
		<primitive: 'primUnsignedWordAtPut' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr value valueOop |
	<export: true>

	valueOop := interpreterProxy stackValue: 0.
	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 1) - 1.
	rcvr := interpreterProxy stackObjectValue: 2.
	value := interpreterProxy positiveMachineIntegerValueOf: valueOop.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: interpreterProxy bytesPerOop inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(interpreterProxy isOopImmutable: rcvr) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoModification].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	self longAt: addr put: value.
	^interpreterProxy methodReturnValue: valueOop