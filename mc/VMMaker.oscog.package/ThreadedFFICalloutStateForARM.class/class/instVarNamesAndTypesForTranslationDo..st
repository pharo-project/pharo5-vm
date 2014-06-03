translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a ReentrantFFICalloutState struct."

	superclass instVarNamesAndTypesForTranslationDo: aBinaryBlock.
	self instVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn caseOf: {
						['integerRegisters']	-> [{#sqInt. '[', ThreadedARMFFIPlugin numIntRegArgs printString, ']'}].
						['floatRegisters']	-> [{#float. '[', ThreadedARMFFIPlugin numFloatRegArgs printString, ']'}] }
					otherwise:
						[#sqInt])]