translating builtins
generateAsIfVarAsValue: aNode on: aStream indent: anInteger

	| cName fName class index fetchNode |
	cName := String streamContents: 
				[:scStr | self emitCExpression: aNode args first on: scStr].
	(class := Smalltalk classNamed: cName) isBehavior ifFalse: 
		[^self error: 'first arg must identify class'].
	fName := aNode args second value.
	index := class
				instVarIndexFor: fName
				ifAbsent: [^self error: 'second arg must be instVar'].
	fetchNode := TSendNode new
					setSelector: #fetchPointer:ofObject:
					receiver: (TVariableNode new setName: 'self')
					arguments: { TConstantNode new setValue: index - 1. aNode receiver}.
	cName := aNode args third nameOrValue.
	(class := Smalltalk classNamed: cName) isBehavior ifFalse: 
		[^self error: 'third arg must identify class'].
	class ccg: self generateCoerceToValueFrom: fetchNode on: aStream
