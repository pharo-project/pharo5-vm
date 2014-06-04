accessing
offsetOf: aByteSymbol
	"These should be generated!!"
	self assert: self objectMemoryClass baseHeaderSize = BaseHeaderSize.
	^aByteSymbol caseOf:
		{	[#methodObject]		-> [8 + BaseHeaderSize].
			[#selector]				-> [16 + BaseHeaderSize].
			[#blockEntryOffset]	-> [6 + BaseHeaderSize].
		}