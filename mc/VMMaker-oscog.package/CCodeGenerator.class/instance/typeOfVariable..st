C code generator
typeOfVariable: varName "<String>" 
	scopeStack reverseDo:
		[:dict|
		(dict includesKey: varName) ifTrue:
			[^self
				extractTypeFor: varName
				fromDeclaration: (dict at: varName)]].
	^self
		extractTypeFor: varName
		fromDeclaration: (variableDeclarations at: varName ifAbsent: [^nil])