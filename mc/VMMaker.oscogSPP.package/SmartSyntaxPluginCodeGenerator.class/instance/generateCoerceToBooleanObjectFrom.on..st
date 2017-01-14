asOop:/asValue:
generateCoerceToBooleanObjectFrom: aNode on: aStream
	pluginFunctionsUsed add: #trueObject; add: #falseObject.
	aStream nextPutAll: '(('.
	self emitCExpression: aNode on: aStream.
	aStream nextPutAll: ') ? trueObject() : falseObject())'