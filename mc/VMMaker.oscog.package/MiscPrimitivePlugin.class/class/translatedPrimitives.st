translation
translatedPrimitives
	"an assorted list of various primitives"
	"MiscPrimitivePlugin browseTranslatedPrimitives"
	^#((Bitmap compress:toByteArray:)
		(Bitmap decompress:fromByteArray:at:)
		(Bitmap encodeBytesOf:in:at:)	"merely a support function"
		(Bitmap encodeInt:in:at:)		"merely a support function"
		(ByteString compare:with:collated:)
		(ByteString translate:from:to:table:)	
		(ByteString findFirstInString:inSet:startingAt:)
		(ByteString indexOfAscii:inString:startingAt:)
		(ByteString findSubstring:in:startingAt:matchTable:)
		(ByteArray hashBytes:startingWith:)
		(SampledSound convert8bitSignedFrom:to16Bit:))