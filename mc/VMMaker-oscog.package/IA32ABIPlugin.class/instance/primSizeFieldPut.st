primitives-accessing
primSizeFieldPut
	"Store a signed integer into the size field (the first 32 bit field; little endian)."
	"<Alien> sizeFieldPut: value <Integer> ^<Integer>
		<primitive: 'primSizeFieldPut' error: errorCode module: 'IA32ABI'>"
	| rcvr value valueOop |
	<export: true>

	valueOop := interpreterProxy stackValue: 0.
	rcvr := interpreterProxy stackValue: 1.
	value := interpreterProxy signed32BitValueOf: valueOop.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	self longAt: rcvr + BaseHeaderSize put: value.
	^interpreterProxy methodReturnValue: valueOop