translating builtins
generateCPtrAsOop: aNode on: aStream indent: anInteger
	aStream nextPutAll: '((sqInt)(sqIntptr_t)('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ') - BaseHeaderSize)'