translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a StackPage struct."

	self allInstVarNames do:
		[:ivn|
		(ivn = 'padToWord' and: [BytesPerWord = 4]) ifFalse:
			[aBinaryBlock
				value: ivn
				value: ((ivn = 'trace' or: [ivn = 'padToWord'])
						ifTrue: [#int]
						ifFalse:
							[(ivn endsWith: 'Page')
								ifTrue: ['struct _StackPage *']
								ifFalse: [#'char *']])]]