primitives-accessing
primSizeField
	"Answer the signed 32- or 64-bit integer comprising the size field (the first 32- or 64-bit field)."
	"<Alien> primSizeField ^<Integer>
		<primitive: 'primSizeField' error: errorCode module: 'IA32ABI'>"
	| rcvr value valueOop |
	<export: true>

	rcvr := interpreterProxy stackValue: 0.
	value := self cppIf: interpreterProxy bytesPerOop = 8
				ifTrue: [(self longAt: rcvr + interpreterProxy baseHeaderSize) signedIntFromLong64]
				ifFalse: [(self longAt: rcvr + interpreterProxy baseHeaderSize) signedIntFromLong].
	valueOop := self signedMachineIntegerFor: value.
	^interpreterProxy methodReturnValue: valueOop