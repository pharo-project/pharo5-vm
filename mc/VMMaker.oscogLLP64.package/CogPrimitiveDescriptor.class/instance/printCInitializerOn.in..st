translation
printCInitializerOn: aStream in: aCCodeGenerator
	<doNotGenerate>
	| first |
	first := true.
	aStream nextPut: ${; space.
	self class instVarNamesAndTypesForTranslationDo:
		[:ivn :type| | value |
		first ifTrue: [first := false] ifFalse: [aStream nextPut: $,; space].
		value := self instVarNamed: ivn.
		aStream nextPutAll: (value
								ifNotNil: [value isSymbol
											ifTrue: [aCCodeGenerator cFunctionNameFor: value]
											ifFalse: [aCCodeGenerator cLiteralFor: value]]
								ifNil: ['0'])].
	aStream space; nextPut: $}