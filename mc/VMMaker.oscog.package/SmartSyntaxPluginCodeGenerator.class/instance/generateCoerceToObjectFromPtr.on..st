asOop:/asValue:
generateCoerceToObjectFromPtr: aNode on: aStream
	"This code assumes no named instance variables"

	aStream nextPutAll: '((int) '.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ') - 4'