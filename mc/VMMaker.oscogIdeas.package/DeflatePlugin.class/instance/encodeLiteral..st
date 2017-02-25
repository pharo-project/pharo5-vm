encoding
encodeLiteral: lit
	"Encode the given literal"
	<inline: true>
	zipLiterals at: zipLiteralCount put: lit.
	zipDistances at: zipLiteralCount put: 0.
	zipLiteralFreq at: lit put: (zipLiteralFreq at: lit) + 1.
	zipLiteralCount := zipLiteralCount + 1.
	^zipLiteralCount = zipLiteralSize "We *must* flush"
		or:[(zipLiteralCount bitAnd: 16rFFF) = 0 "Only check every N kbytes"
			and:[self shouldFlush]]