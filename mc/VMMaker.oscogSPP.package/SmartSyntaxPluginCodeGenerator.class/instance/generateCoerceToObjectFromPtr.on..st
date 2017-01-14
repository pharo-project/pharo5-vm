asOop:/asValue:
generateCoerceToObjectFromPtr: aNode on: aStream
	"This code assumes no named instance variables"

	aStream nextPutAll: '((sqInt)(('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ') - BaseHeaderSize))'