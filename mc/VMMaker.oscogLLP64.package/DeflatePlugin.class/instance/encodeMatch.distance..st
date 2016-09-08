encoding
encodeMatch: length distance: dist
	"Encode the given match of length length starting at dist bytes ahead"
	| literal distance |
	<inline: true>
	zipLiterals at: zipLiteralCount put: length - DeflateMinMatch.
	zipDistances at: zipLiteralCount put: dist.
	literal := (zipMatchLengthCodes at: length - DeflateMinMatch).
	zipLiteralFreq at: literal put: (zipLiteralFreq at: literal) + 1.
	dist < 257
		ifTrue:[distance := zipDistanceCodes at: dist - 1]
		ifFalse:[distance := zipDistanceCodes at: 256 + (dist - 1 bitShift: -7)].
	zipDistanceFreq at: distance put: (zipDistanceFreq at: distance) + 1.
	zipLiteralCount := zipLiteralCount + 1.
	zipMatchCount := zipMatchCount + 1.
	^zipLiteralCount = zipLiteralSize "We *must* flush"
		or:[(zipLiteralCount bitAnd: 16rFFF) = 0 "Only check every N kbytes"
			and:[self shouldFlush]]