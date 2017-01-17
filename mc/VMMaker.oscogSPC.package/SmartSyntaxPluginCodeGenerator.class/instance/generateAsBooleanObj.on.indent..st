translating builtins
generateAsBooleanObj: aNode on: aStream indent: anInteger
	pluginFunctionsUsed add: #trueObject; add: #falseObject.
	aStream nextPutAll: '(('.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPutAll: ') ? trueObject() : falseObject())'.