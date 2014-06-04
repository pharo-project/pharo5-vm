translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a CogVMThread struct."

	self allInstVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn caseOf: {
						['awolProcesses']			-> [{#sqInt. '[', CogThreadManager awolProcessesIncrement printString, ']'}].
						['cStackPointer']			-> [#'void *'].
						['cFramePointer']		-> [#'void *'].
						['osSemaphore']			-> ['sqOSSemaphore'].
						['osThread']				-> ['sqOSThread'].
						['reenterInterpreter']	-> ['jmp_buf'] }
					otherwise:
						[#sqInt])]