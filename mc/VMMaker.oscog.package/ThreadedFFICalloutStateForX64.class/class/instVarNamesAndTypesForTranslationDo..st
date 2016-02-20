translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a ThreadedFFICalloutState struct."

	ThreadedFFICalloutState instVarNamesAndTypesForTranslationDo: aBinaryBlock.
	self instVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn caseOf: {
						['integerRegisters']	-> [{#sqInt. '[', self pluginClass numRegArgs printString, ']'}].
						['floatRegisters']	-> [{#double. '[', self pluginClass numFloatRegArgs printString, ']'}] }
					otherwise:
						[#sqInt])]