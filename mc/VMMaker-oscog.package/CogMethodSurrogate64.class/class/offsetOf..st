accessing
offsetOf: aByteSymbol 
	^aByteSymbol caseOf:
		{	[#methodObject]	-> [16].
			[#selector]			-> [32].
			[#blockEntryOffset]	-> [14].
		}