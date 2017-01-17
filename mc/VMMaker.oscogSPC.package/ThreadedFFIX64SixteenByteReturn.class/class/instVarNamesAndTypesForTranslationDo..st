translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a BlockStart struct."

	self instVarNames do:
		[:ivn|
		aBinaryBlock value: ivn value: #sqInt]