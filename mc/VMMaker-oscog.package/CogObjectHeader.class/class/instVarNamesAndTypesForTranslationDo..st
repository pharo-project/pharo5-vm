translation
instVarNamesAndTypesForTranslationDo: aBinaryBlock
	"enumerate aBinaryBlock with the names and C type strings for the inst vars to include in a BytecodeDescriptor struct."
	"self typedef"

	self instVarNames do:
		[:ivn|
		aBinaryBlock
			value: ivn
			value: (ivn caseOf: {
							['classIndex']	->	[#'unsigned short']. "for speed; can extend to 22 bits by absorbing unused0"
							['unused0']		->	[#(unsigned ' : 6')].
							['format']		->	[#(unsigned ' : 5')].
							['objHash']		->	[#(unsigned ' : 24')].
							['slotSize']		->	[#'unsigned char'] }
						otherwise: [#(#unsigned #Boolean ' : 1')])]