accessing
offsetOf: aByteSymbol 
	^aByteSymbol caseOf:
		{	[#methodObject]	-> [12].
			[#selector]			-> [20].
			[#blockEntryOffset]	-> [10].
		}