translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"Enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a BytecodeFixup struct."
	"self withAllSubclasses collect: [:ea| ea typedef]"

	self filteredInstVarNames do:
		[:ivn|
		 aBinaryBlock
			value: ivn
			value: (ivn first ~= $# ifTrue:
						[ivn caseOf: {
							['targetInstruction']			-> [#'AbstractInstruction *'].
							['mergeSimStack']			-> [#'SimStackEntry *'].
							['instructionIndex']			-> [#'unsigned short'].
							['simStackPtr']				-> [#char].
							['simNativeStackPtr']		-> [#'unsigned short'].
							['simNativeStackSize']		-> [#'unsigned short'].
							['isReceiverResultRegSelf']	-> [#char] }])]