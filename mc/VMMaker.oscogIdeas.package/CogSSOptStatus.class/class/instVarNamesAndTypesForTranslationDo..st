translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a CogSSOptStatus struct."

	self instVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn = 'ssEntry'
					ifTrue: [#'CogSimStackEntry *']
					ifFalse: [#sqInt])]