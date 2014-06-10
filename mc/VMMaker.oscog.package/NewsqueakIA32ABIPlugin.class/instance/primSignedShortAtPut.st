primitives-accessing
primSignedShortAtPut
	"Store a signed integer into 16 bits starting at the given byte offset (little endian)."
	"<Alien> signedShortAt: index <Integer> put: value <Integer> ^<Integer>
		<primitive: 'primSignedShortAtPut' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr value valueOop |
	<export: true>

	valueOop := interpreterProxy stackValue: 0.
	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 1) - 1.
	rcvr := interpreterProxy stackObjectValue: 2.
	value := interpreterProxy signed32BitValueOf: valueOop.
	(interpreterProxy failed
	or: [value < -32768
	or: [value > 32767]]) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: 2 inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(interpreterProxy isOopImmutable: rcvr) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoModification].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	self shortAt: addr put: value.
	^interpreterProxy methodReturnValue: valueOop