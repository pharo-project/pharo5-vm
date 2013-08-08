translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a StackPage struct."

	self allInstVarNames do:
		[:ivn|
		ivn ~= 'stackPagesMemory' ifTrue:
			[aBinaryBlock
				value: ivn
				value: (ivn = 'trace'
						ifTrue: [#int]
						ifFalse:
							[(ivn endsWith: 'Page')
								ifTrue: ['struct _StackPage *']
								ifFalse: [#'char *']])]]