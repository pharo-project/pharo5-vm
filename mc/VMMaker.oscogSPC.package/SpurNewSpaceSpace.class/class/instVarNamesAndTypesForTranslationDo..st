translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	self allInstVarNames do:
		[:ivn|
		(SpurMemoryManager isNonArgumentImplicitReceiverVariableName: ivn) ifFalse:
			[aBinaryBlock value: ivn value: #usqInt]]