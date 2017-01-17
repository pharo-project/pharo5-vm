translating builtins
genCallOf: aSelector with: aNode on: aStream
	pluginFunctionsUsed add: aSelector.
	aStream nextPutAll: (self cFunctionNameFor: aSelector).
	aStream nextPut: $(.
	self emitCExpression: aNode on: aStream.
	aStream nextPut: $)