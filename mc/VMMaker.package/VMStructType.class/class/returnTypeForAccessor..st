translation
returnTypeForAccessor: aSelector
	| varName deStructTag |
	varName := aSelector copyWithout: $:.
	deStructTag := [:decl| decl copyReplaceAll: 'struct ', self structTagName with: self structTypeName].
	self instVarNamesAndTypesForTranslationDo:
		[:var :typeSpec|
		var = varName ifTrue:
			[^typeSpec isArray
				ifTrue: [(deStructTag value: typeSpec first), ' ', typeSpec last]
				ifFalse: [deStructTag value: typeSpec]]].
	^nil


	"InterpreterStackPage returnTypeForAccessor: #nextPage:"