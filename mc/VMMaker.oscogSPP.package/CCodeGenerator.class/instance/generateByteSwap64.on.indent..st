C translation
generateByteSwap64: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: #'SQ_SWAP_8_BYTES'.
	aStream nextPut: $(.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)