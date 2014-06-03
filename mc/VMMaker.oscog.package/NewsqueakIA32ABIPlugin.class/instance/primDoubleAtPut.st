primitives-accessing
primDoubleAtPut
	"Store a double into 64 bits starting at the given byte offset (little endian)."
	"<Alien> doubleAt: index <Integer> put: value <Float | Integer> ^<Float | Integer>
		<primitive: 'primDoubleAtPut' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr startAddr addr valueOop floatValue |
	<export: true>
	<var: #floatValue type: #double>

	valueOop := interpreterProxy stackValue: 0.
	(interpreterProxy isIntegerObject: valueOop)
		ifTrue:[floatValue := self cCoerce: (interpreterProxy integerValueOf: valueOop) to: #double]
		ifFalse:[floatValue := self cCoerce: (interpreterProxy floatValueOf: valueOop) to: #double].
	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 1) - 1.
	rcvr := interpreterProxy stackObjectValue: 2.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: 8 inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	(interpreterProxy isOopImmutable: rcvr) ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrNoModification].
	(startAddr := self startOfData: rcvr) = 0 ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadReceiver].
	addr := startAddr + byteOffset.
	self cCode:'((int*)addr)[0] = ((int*)(&floatValue))[0]'.
	self cCode:'((int*)addr)[1] = ((int*)(&floatValue))[1]'.
	interpreterProxy methodReturnValue: valueOop