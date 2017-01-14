translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a CogSimStackEntry struct."
	"self printTypedefOn: Transcript"
	self filteredInstVarNames do:
		[:ivn|
		aBinaryBlock
			value: (ivn = 'register' ifTrue: ['registerr'] ifFalse: [ivn]) "avoid reservedWord conflict"
			value: (ivn caseOf: {
						['constantInt64']			-> [#sqLong].
						['constantFloat32']			-> [#float].
						['constantFloat64']			-> [#double].
						['type']			-> [#char].
						['spilled']		-> [#char].}
					otherwise:
						[#sqInt])]