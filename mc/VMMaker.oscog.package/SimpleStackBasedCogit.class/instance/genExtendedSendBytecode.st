bytecode generators
genExtendedSendBytecode
	"Can use any of the first 32 literals for the selector and pass up to 7 arguments."

	^self genSend: (byte1 bitAnd: 16r1F) numArgs: byte1 >> 5