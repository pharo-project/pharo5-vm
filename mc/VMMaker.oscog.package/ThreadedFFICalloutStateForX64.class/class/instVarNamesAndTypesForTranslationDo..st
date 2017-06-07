translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a ThreadedFFICalloutState struct."
	"self subclasses collect: [:ea| ea -> ea typdef]"
	ThreadedFFICalloutState instVarNamesAndTypesForTranslationDo: aBinaryBlock.
	self instVarNames, ThreadedFFICalloutStateForX64 instVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn caseOf: {
						['integerRegisters']	-> [{#sqInt. '[NumIntRegArgs]'}].
						['floatRegisters']	-> [{#double. '[NumFloatRegArgs]'}] }
					otherwise:
						[#char])]