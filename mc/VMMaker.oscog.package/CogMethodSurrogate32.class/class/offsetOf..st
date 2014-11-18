accessing
offsetOf: aByteSymbol
	"These should be generated!!"
	| baseHeaderSize |
	baseHeaderSize := self objectMemoryClass baseHeaderSize.
	^aByteSymbol caseOf:
		{	[#methodObject]		-> [8 + baseHeaderSize].
			[#selector]				-> [16 + baseHeaderSize].
			[#blockEntryOffset]	-> [6 + baseHeaderSize].
		}