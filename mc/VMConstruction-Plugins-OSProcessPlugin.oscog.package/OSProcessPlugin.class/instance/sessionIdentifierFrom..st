private - conversion
sessionIdentifierFrom: aByteArray
	"Answer a session ID represented by aByteArray. The session ID is used in
	the SQFile structure. If that data structure changes, we should see compiler
	warnings about type mismatch with SESSIONIDENTIFIERTYPE."

	| session sessionUnion idx |
	<returnTypeC: 'SESSIONIDENTIFIERTYPE'>
	<var: 'session' declareC: 'unsigned char *session'>
	<var: 'sessionUnion'
		declareC: 'union {SESSIONIDENTIFIERTYPE session; unsigned char bytes[sizeof(SESSIONIDENTIFIERTYPE)];} sessionUnion'>
	((interpreterProxy isBytes: aByteArray) and:
		[(interpreterProxy stSizeOf: aByteArray) = self sizeOfSession])
		ifFalse: [^ nil].
	session := interpreterProxy arrayValueOf: aByteArray.
	idx := 0.
	[idx < self sizeOfSession]	whileTrue:
		[self cCode: 'sessionUnion.bytes[idx] = session[idx]'.
		idx := idx + 1].
	^ self cCode: 'sessionUnion.session' inSmalltalk: [sessionUnion]
