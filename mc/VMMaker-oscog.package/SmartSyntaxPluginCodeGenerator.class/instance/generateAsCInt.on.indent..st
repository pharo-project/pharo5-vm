translating builtins
generateAsCInt: aNode on: aStream indent: anInteger

	aStream nextPut: $(.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ' >> 1)'.