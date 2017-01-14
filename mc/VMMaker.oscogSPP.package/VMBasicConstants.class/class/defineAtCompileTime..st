C translation
defineAtCompileTime: anObject
	^anObject isSymbol
	 and: [self namesDefinedAtCompileTime includes: anObject]