C code generator
typeOfVariable: varName "<String>"
	self assert: varName isString.
	scopeStack reverseDo:
		[:dict|
		(dict includesKey: varName) ifTrue:
			[^self
				extractTypeFor: varName
				fromDeclaration: (dict at: varName)]].
	^self
		extractTypeFor: varName
		fromDeclaration: (variableDeclarations
							at: varName
							ifAbsent:
								[apiVariables
									ifNotNil: [apiVariables at: varName ifAbsent: [^nil]]
									ifNil: [^nil]])