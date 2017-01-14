primitives-accessing
primStrlenFromStartIndex
	"Answer the number of non-null bytes starting at index.  If
	 there isn't a null byte before the end of the object then the
	 result will be the number of bytes from index to the end of
	 the object, i.e. the result will be within the bounds of the object."
	"<Alien> primStrlenFrom: index <Integer> ^<Integer>
		<primitive: 'primStrlenFromStartIndex' error: errorCode module: 'IA32ABI'>"
	| byteOffset rcvr index limit ptr |
	<export: true>
	<var: #ptr type: #'char *'>

	byteOffset := (interpreterProxy stackPositiveMachineIntegerValue: 0) - 1.
	rcvr := interpreterProxy stackObjectValue: 1.
	interpreterProxy failed ifTrue:
		[^interpreterProxy primitiveFailFor: PrimErrBadArgument].
	(self index: byteOffset length: 1 inRange: rcvr) ifFalse:
		[^interpreterProxy primitiveFailFor: PrimErrBadIndex].
	limit := self sizeField: rcvr.
	ptr := self cCoerce: ((self startOfData: rcvr withSize: limit) + byteOffset) to: #'char *'.
	limit = 0
		ifTrue: [index := self strlen: ptr]
		ifFalse:
			[limit := limit abs.
			 index := 0.
			 [index < limit
			  and: [(self cCode: 'ptr[index]' inSmalltalk: [ptr byteAt: index]) ~= 0]] whileTrue:
				[index := index + 1]].
	^interpreterProxy methodReturnValue: (interpreterProxy positive32BitIntegerFor: index)