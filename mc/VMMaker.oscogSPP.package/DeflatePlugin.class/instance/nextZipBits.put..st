encoding
nextZipBits: nBits put: value
	"Require:
		zipCollection, zipCollectionSize, zipPosition,
		zipBitBuf, zipBitPos.
	"
	<inline: true>
	(value >= 0 and:[(1 << nBits) > value])
		ifFalse:[^interpreterProxy primitiveFail].
	zipBitBuf := zipBitBuf bitOr: value << zipBitPos.
	zipBitPos := zipBitPos + nBits.
	[zipBitPos >= 8 and:[zipPosition < zipCollectionSize]] whileTrue:[
		zipCollection at: zipPosition put: (zipBitBuf bitAnd: 255).
		zipPosition := zipPosition + 1.
		zipBitBuf := zipBitBuf >> 8.
		zipBitPos := zipBitPos - 8].
