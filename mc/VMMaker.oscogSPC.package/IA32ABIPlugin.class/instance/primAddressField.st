primitives-accessing
primAddressField
	"Answer the unsigned 32-bit (or 64-bit) integer comprising the address field (the second 32-bit or 64-bit field)."
	"<Alien> primAddressField ^<Integer>
		<primitive: 'primAddressField' error: errorCode module: 'IA32ABI'>"
	| rcvr value valueOop |
	<export: true>
	rcvr := interpreterProxy stackValue: 0.
	value := self longAt: rcvr + interpreterProxy baseHeaderSize + interpreterProxy bytesPerOop.
	valueOop := self positiveMachineIntegerFor: value.
	^interpreterProxy methodReturnValue: valueOop