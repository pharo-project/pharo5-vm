bytecode generators
genSecondExtendedSendBytecode
	"Can use any of the first 64 literals for the selector and pass up to 3 arguments."

	^self genSend: (byte1 bitAnd: 16r3F) numArgs: byte1 >> 6