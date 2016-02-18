primitives-accessing
primUnsignedShortAtPut
	"Store an unsigned integer into 16 bits starting at the given byte offset (little endian)."
	"<Alien> unsignedShortAt: index <Integer> put: value <Integer> ^<Integer>
		<primitive: 'primUnsignedShortAtPut' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr value valueOop |
	<export: true>

	valueOop := interpreterProxy stackValue: 0.
	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 1) - 1.
	rcvr := interpreterProxy stackObjectValue: 2.
	value := interpreterProxy positive32BitValueOf: valueOop.
	(interpreterProxy failed
	or: [value > 65535]) ifTrue:
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