translating builtins
generateAsIfVar: aNode on: aStream indent: anInteger

	| cName fName class index |
	cName := String streamContents: 
		[:scStr | self emitCExpression: aNode args first on: scStr].
	(class := Smalltalk classNamed: cName) isBehavior ifFalse: 
		[^self error: 'first arg must identify class'].
	fName := aNode args second value.
	index := class
				instVarIndexFor: fName
				ifAbsent: [^self error: 'second arg must be instVar'].
	pluginFunctionsUsed add: #fetchPointer:ofObject:.
	aStream nextPutAll: 'fetchPointerofObject('; print: index - 1; nextPut: $,.
	self emitCExpression: aNode receiver on: aStream.
	aStream nextPut: $)