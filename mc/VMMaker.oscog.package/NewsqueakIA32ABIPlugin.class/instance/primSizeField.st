primitives-accessing
primSizeField
	"Answer the signed 32-bit integer comprising the size field (the first 32-bit field)."
	"<Alien> primSizeField ^<Integer>
		<primitive: 'primSizeField' error: errorCode module: 'IA32ABI'>"
	| rcvr value valueOop |
	<export: true>

	rcvr := interpreterProxy stackValue: 0.
	value := self longAt: rcvr + BaseHeaderSize.
	valueOop := interpreterProxy signed32BitIntegerFor: value.
	^interpreterProxy methodReturnValue: valueOop