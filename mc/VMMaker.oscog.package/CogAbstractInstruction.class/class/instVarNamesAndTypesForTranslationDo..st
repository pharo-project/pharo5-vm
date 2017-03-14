translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"Enumerate aBinaryBlock with the names and C type strings for the inst vars to include in an AbstractInstruction struct."
	"(CogAbstractInstruction withAllSubclasses reject: [:c| c name includesSubString: 'ForTests']) do:
		[:c| Transcript print: c; cr. c printTypedefOn: Transcript]"
	(self filteredInstVarNames copyWithout: 'machineCode'), #('machineCode') do:
		[:ivn|
		 aBinaryBlock
			value: ivn
			value: (ivn caseOf: {
						['address']			-> [#usqInt]. "usqInt is always large enough to contain a pointer; we do not need to use usqIntptr_t"
						['machineCode']	-> [self machineCodeDeclaration].
						['operands']		-> [{#usqInt. '[', NumOperands, ']'}].
						['dependent']		-> ['struct _AbstractInstruction *']}
					otherwise:
						[#'unsigned char'])]