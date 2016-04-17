translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a CogRASSBytecodeFixup struct."

	self allInstVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn caseOf: {
					['targetInstruction']	-> [#'AbstractInstruction *'].
					['mergeSimStack']	-> [#'CogSimStackEntry *'] }
					otherwise: [#sqInt])]