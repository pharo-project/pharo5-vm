translation
translatedPrimitives
	"an assorted list of various primitives"
	PharoVM ifTrue: [ ^ self translatedPrimitivesForPharo ].
	^#(
		(Bitmap compress:toByteArray:)
		(Bitmap decompress:fromByteArray:at:)
		(Bitmap encodeBytesOf:in:at:)
		(Bitmap encodeInt:in:at:)
		(ByteString compare:with:collated:)
		(ByteString translate:from:to:table:)	
		(ByteString findFirstInString:inSet:startingAt:)
		(ByteString indexOfAscii:inString:startingAt:)
		(ByteString findSubstring:in:startingAt:matchTable:)
		(ByteArray hashBytes:startingWith:)
		(SampledSound convert8bitSignedFrom:to16Bit:)
	)

	"| tps |
	'This opens a list browser on all translated primitives in the image'.
	 tps := (SystemNavigation default allImplementorsOf: #translatedPrimitives)
				inject: Set new
				into: [:tp :mr|
					tp addAll: (mr actualClass theNonMetaClass translatedPrimitives collect:
								[:pair|
								MethodReference
									class: (((Smalltalk at: pair first) canUnderstand: pair last)
												ifTrue: [Smalltalk at: pair first]
												ifFalse: [(Smalltalk at: pair first) class])
									selector: pair last]);
						yourself].
	SystemNavigation default browseMessageList: tps asArray sort name: 'Translated Primitives' "