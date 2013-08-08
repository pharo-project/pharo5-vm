private - conversion
pointerFrom: aByteArray
	"Answer the pointer represented by aByteArray."

	| ptr pointerUnion idx |
	<returnTypeC: 'void *'>
	<var: 'ptr' declareC: 'unsigned char *ptr'>
	<var: 'pointerUnion'
		declareC: 'union {void *address; unsigned char bytes[sizeof(void *)];} pointerUnion'>
	((interpreterProxy isBytes: aByteArray) and:
		[(interpreterProxy stSizeOf: aByteArray) = self sizeOfPointer])
		ifFalse: [^ nil].
	ptr := interpreterProxy arrayValueOf: aByteArray.
	idx := 0.
	[idx < self sizeOfPointer]	whileTrue:
		[self cCode: 'pointerUnion.bytes[idx] = ptr[idx]'.
		idx := idx + 1].
	^ self cCode: 'pointerUnion.address' inSmalltalk: [pointerUnion]
