translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a ThreadedFFICalloutState struct."

	ThreadedFFICalloutStateForX64 instVarNamesAndTypesForTranslationDo: aBinaryBlock.
	ThreadedFFICalloutStateForX64Win64 instVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn caseOf: {
						['floatRegisterSignature']	-> [#int] }
					otherwise:
						[#sqInt])]