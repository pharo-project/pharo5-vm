translation
translatedPrimitivesForPharo
	^#(
		(Bitmap compress:toByteArray:)
		(Bitmap decompress:fromByteArray:at:)
		(Bitmap encodeBytesOf:in:at:)
		(Bitmap encodeInt:in:at:)
		(ByteString compare:with:collated:)
		(ByteString translate:from:to:table:)	
		(ByteString findFirstInString:inSet:startingAt:)
		(ByteString indexOfAscii:inString:startingAt:)
		(String findSubstringViaPrimitive:in:startingAt:matchTable:)
		(ByteArray hashBytes:startingWith:)
		(SampledSound convert8bitSignedFrom:to16Bit:)
	)