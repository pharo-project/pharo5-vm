translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a CogInstructionAnnotation struct."

	self allInstVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn = 'instruction'
					ifTrue: [#'AbstractInstruction *']
					ifFalse: [#sqInt])]