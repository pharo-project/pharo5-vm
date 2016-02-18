translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a PrimitiveDescriptor struct."

	self instVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn = 'primitiveGenerator'
					ifTrue: [#('sqInt (*' ')(void)')]
					ifFalse: [#sqInt])]