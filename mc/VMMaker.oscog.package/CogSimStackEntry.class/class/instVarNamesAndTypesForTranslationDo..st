translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"Enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a CogSimStackEntry struct."
	"self typedef"
	self filteredInstVarNames do:
		[:ivn|
		aBinaryBlock
			value: (ivn = 'register' ifTrue: ['registerr'] ifFalse: [ivn]) "avoid reservedWord conflict"
			value: (ivn caseOf: {
						['type']			-> [#char].
						['spilled']		-> [#char].
						['register']		-> [#'signed char']. "because NoReg = -1"
						['liveRegister']	-> [#'signed char'].}
					otherwise:
						[#sqInt])]