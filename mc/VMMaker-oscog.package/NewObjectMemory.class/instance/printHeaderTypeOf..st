debug printing
printHeaderTypeOf: obj
	(self headerType: obj) caseOf: {
		[HeaderTypeFree]			-> [coInterpreter print: ' HeaderTypeFree (4 bytes)'].
		[HeaderTypeShort]			-> [coInterpreter print: ' HeaderTypeShort (4 bytes)'].
		[HeaderTypeClass]			-> [coInterpreter print: ' HeaderTypeClass (8 bytes)'].
		[HeaderTypeSizeAndClass]	-> [coInterpreter print: ' HeaderTypeSizeAndClass (12 bytes)'] }