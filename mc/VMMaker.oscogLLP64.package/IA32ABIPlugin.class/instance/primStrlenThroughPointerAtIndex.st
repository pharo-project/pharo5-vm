primitives-accessing
primStrlenThroughPointerAtIndex
	"Answer the number of non-null bytes starting at the byte addressed by
	 the 4-byte pointer at index."
	"<Alien> strlenThroughPointerAt: index <Integer> ^<Integer>
		<primitive: 'primStrlenThroughPointerAtIndex' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr ptr addr |
	<export: true>
	<var: #ptr type: #'char *'>

	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 0) - 1.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: interpreterProxy bytesPerOop inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	addr := (self startOfData: rcvr) + byteOffset.
	ptr := self cCoerce: (self longAt: addr) to: #'char *'.
	^interpreterProxy methodReturnValue: (interpreterProxy positive32BitIntegerFor: (self strlen: ptr))