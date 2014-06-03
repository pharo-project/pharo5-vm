translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in an AbstractInstruction struct."
	"{CogAbstractInstruction. CogIA32Compiler. CogARMCompiler} do:
		[:c| Transcript print: c; cr. c printTypedefOn: Transcript]"
	| machineCodeBytes |
	machineCodeBytes := self ==  CogAbstractInstruction
								ifTrue: [0]
								ifFalse: [self basicNew machineCodeBytes].
	(self filteredInstVarNames copyWithout: 'machineCode'), #('machineCode') do:
		[:ivn|
		ivn ~= 'bcpc' ifTrue:
			[aBinaryBlock
				value: ivn
				value: (ivn caseOf: {
							['address']			-> ['unsigned long'].
							['machineCode']	-> [{'unsigned char'. '[', machineCodeBytes printString, ']'}].
							['operands']		-> [{'unsigned long'. '[', NumOperands printString, ']'}].
							['dependent']		-> ['struct _AbstractInstruction *']}
						otherwise:
							[#char])]]