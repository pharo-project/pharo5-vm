C translation
generateByteSwap32: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: #'SQ_SWAP_4_BYTES'.
	aStream nextPut: $(.
	self emitCExpression: msgNode receiver on: aStream.
	aStream nextPut: $)