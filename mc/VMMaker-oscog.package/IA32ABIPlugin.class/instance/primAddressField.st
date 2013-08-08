primitives-accessing
primAddressField
	"Answer the unsigned 32-bit integer comprising the address field (the second 32-bit field)."
	"<Alien> primAddressField ^<Integer>
		<primitive: 'primAddressField' error: errorCode module: 'IA32ABI'>"
	| rcvr value valueOop |
	<export: true>
	rcvr := interpreterProxy stackValue: 0.
	value := self longAt: rcvr + BaseHeaderSize + BytesPerOop.
	valueOop := interpreterProxy positive32BitIntegerFor: value.
	^interpreterProxy methodReturnValue: valueOop