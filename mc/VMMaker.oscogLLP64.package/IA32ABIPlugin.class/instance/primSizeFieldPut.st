primitives-accessing
primSizeFieldPut
	"Store a signed integer into the size field (the first 32 bit field; little endian)."
	"<Alien> sizeFieldPut: value <Integer> ^<Integer>
		<primitive: 'primSizeFieldPut' error: errorCode module: 'IA32ABI'>"
	| rcvr value valueOop |
	<export: true>

	valueOop := interpreterProxy stackValue: 0.
	rcvr := interpreterProxy stackValue: 1.
	value := interpreterProxy signedMachineIntegerValueOf: valueOop.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self cppIf: interpreterProxy bytesPerOop = 8
		ifTrue: [self longAt: rcvr + interpreterProxy baseHeaderSize put: value signedIntToLong64]
		ifFalse: [self longAt: rcvr + interpreterProxy baseHeaderSize put: value signedIntToLong]).
	^interpreterProxy methodReturnValue: valueOop