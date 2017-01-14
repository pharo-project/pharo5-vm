translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a BytecodeFixup struct."

	self allInstVarNames do:
		[:ivn|
		ivn ~= 'bcpc' ifTrue:
			[aBinaryBlock
				value: ivn
				value: (ivn = 'targetInstruction'
						ifTrue: [#'AbstractInstruction *']
						ifFalse:
							[#sqInt])]]