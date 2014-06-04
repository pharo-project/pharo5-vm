primitives-accessing
primAddressFieldPut
	"Store an unsigned integer into the size field (the second 32 bit field; little endian)."
	"<Alien> addressFieldPut: value <Integer> ^<Integer>
		<primitive: 'primAddressFieldPut' error: errorCode module: 'IA32ABI'>"
	| rcvr value valueOop |
	<export: true>
	valueOop := interpreterProxy stackValue: 0.
	rcvr := interpreterProxy stackValue: 1.
	value := interpreterProxy positive32BitValueOf: valueOop.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(interpreterProxy isOopImmutable: rcvr) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoModification].
	self longAt: rcvr + BaseHeaderSize + BytesPerOop put: value.
	^interpreterProxy methodReturnValue: valueOop