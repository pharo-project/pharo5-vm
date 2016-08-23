translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a ThreadedFFICalloutState struct."

	self instVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn caseOf: {
						['argVector']	-> [#'char *'].
						['currentArg']	-> [#'char *'].
						['limit']			-> [#'char *'].
						['ffiArgSpec']	-> [#'void *'].
						['stringArgs']	-> [{#'char *'. '[MaxNumArgs]'}] }
					otherwise:
						[#sqInt])]