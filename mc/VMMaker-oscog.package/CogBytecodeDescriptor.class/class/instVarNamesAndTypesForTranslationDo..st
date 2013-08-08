translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a BytecodeDescriptor struct."

	self instVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn caseOf: {
							['generator']			->	[#('sqInt (*' ')(void)')].
							['spanFunction']			->	[#('sqInt (*' ')(struct _BytecodeDescriptor *,sqInt,sqInt,sqInt)')].
							['needsFrameFunction']	->	[#('sqInt (*' ')(sqInt)')].
							['numBytes']			->	['unsigned char'].
							['stackDelta']			->	['signed char'].
							['opcode']				->	['unsigned char'] }
						otherwise: [#('unsigned' ' : 1')])]