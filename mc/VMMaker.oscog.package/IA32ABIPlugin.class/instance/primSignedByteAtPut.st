primitives-accessing
primSignedByteAtPut
	"Store a signed integer into 8 bits starting at the given byte offset (little endian)."
	"<Alien> signedByteAt: index <Integer> put: value <Integer> ^<Integer>
		<primitive: 'primSignedByteAtPut' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr value valueOop |
	<export: true>

	valueOop := interpreterProxy stackValue: 0.
	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 1) - 1.
	rcvr := interpreterProxy stackObjectValue: 2.
	value := interpreterProxy signed32BitValueOf: valueOop.
	(interpreterProxy failed
	or: [value < -128
	or: [value > 127]]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: 1 inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(interpreterProxy isOopImmutable: rcvr) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoModification].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	self byteAt: addr put: value.
	^interpreterProxy methodReturnValue: valueOop