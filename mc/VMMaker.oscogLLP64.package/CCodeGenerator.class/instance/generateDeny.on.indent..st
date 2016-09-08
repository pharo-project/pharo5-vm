C translation
generateDeny: denyMsgNode on: aStream indent: level
	"Generate the C code for a deny: expr onto the given stream."

	aStream nextPutAll: 'assert(!('.
	self emitCExpression: denyMsgNode args first on: aStream.
	aStream nextPutAll: '))'