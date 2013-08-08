pool definition
initializeInstVarNames: aClass prefixedBy: aString

	| token |
	aClass instVarNames doWithIndex:[:instVarName :index| | value |
		token := (aString, instVarName first asUppercase asString, (instVarName copyFrom: 2 to: instVarName size),'Index') asSymbol.
		value := index - 1.
		(self bindingOf: token) ifNil:[self addClassVarName: token].
		(self bindingOf: token) value: value.
	].
	token := (aString, aClass name,'Size') asSymbol.
	(self bindingOf: token) ifNil:[self addClassVarName: token].
	(self bindingOf: token) value: aClass instSize.