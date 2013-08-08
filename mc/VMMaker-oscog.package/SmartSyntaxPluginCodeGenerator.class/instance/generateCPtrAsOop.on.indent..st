translating builtins
generateCPtrAsOop: aNode on: aStream indent: anInteger

	aStream nextPutAll: '((sqInt)(long)('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ') - ';
		nextPutAll: ObjectMemory baseHeaderSize printString;
		nextPut: $).