accessing
offsetOf: aByteSymbol
	"These should be generated!!"
	| baseHeaderSize |
	baseHeaderSize := self objectMemoryClass baseHeaderSize.
	^aByteSymbol caseOf:
		{	[#methodObject]		-> [8 + baseHeaderSize].
			[#methodHeader]		-> [16 + baseHeaderSize].
			[#selector]				-> [24 + baseHeaderSize].
			[#blockEntryOffset]	-> [6 + baseHeaderSize].
		}