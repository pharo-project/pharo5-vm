C translation
generateByteSwap32IfBigEndian: msgNode on: aStream indent: level
	"Generate the C code for this message onto the given stream."

	aStream nextPutAll: #'SQ_SWAP_4_BYTES_IF_BIGENDIAN'.
	aStream nextPut: $(.
	self emitCExpression: msgNode args first on: aStream.
	aStream nextPut: $)