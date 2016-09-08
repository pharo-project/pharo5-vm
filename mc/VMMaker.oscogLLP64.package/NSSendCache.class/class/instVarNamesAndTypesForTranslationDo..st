translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock

	self allInstVarNames do:
		[:ivn| aBinaryBlock
				value: ivn
				value: #'sqInt']