private - handle conversion
handleFrom: aHandleObject
	"Answer the HANDLE represented by aHandleObject."

	| ptr handleUnion idx |
	<returnTypeC: 'HANDLE'>
	<var: 'ptr' type: 'unsigned char *'>
	<var: 'handleUnion' type: 'union {void *address; unsigned char bytes[sizeof(void *)];}'>
	((interpreterProxy isBytes: aHandleObject) and:
			[(interpreterProxy stSizeOf: aHandleObject) = self sizeOfHandle])
		ifFalse:
			[interpreterProxy primitiveFail.
			^ nil].
	ptr := interpreterProxy arrayValueOf: aHandleObject.
	idx := 0.
	[idx < self sizeOfHandle]	whileTrue:
		[self cCode: 'handleUnion.bytes[idx] = ptr[idx]'.
		idx := idx + 1].
	^ self cCode: 'handleUnion.address' inSmalltalk: [handleUnion]
