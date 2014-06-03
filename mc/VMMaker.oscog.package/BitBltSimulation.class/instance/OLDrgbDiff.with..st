combination rules
OLDrgbDiff: sourceWord with: destinationWord
	"Subract the pixels in the source and destination, color by color,
	and return the sum of the absolute value of all the differences.
	For non-rgb, XOR the two and return the number of differing pixels.
	Note that the region is not clipped to bit boundaries, but only to the
	nearest (enclosing) word.  This is because copyLoop does not do
	pre-merge masking.  For accurate results, you must subtract the
	values obtained from the left and right fringes."
	| diff pixMask |
	<inline: false>
	destDepth < 16 ifTrue:
		["Just xor and count differing bits if not RGB"
		diff := sourceWord bitXor: destinationWord.
		pixMask := maskTable at: destDepth.
		[diff = 0] whileFalse:
			[(diff bitAnd: pixMask) ~= 0 ifTrue: [bitCount := bitCount + 1].
			diff := diff >> destDepth].
		^ destinationWord "for no effect"].
 	destDepth = 16
		ifTrue:
		[diff := (self partitionedSub: sourceWord from: destinationWord
						nBits: 5 nPartitions: 3).
		bitCount := bitCount + (diff bitAnd: 16r1F)
							+ (diff>>5 bitAnd: 16r1F)
							+ (diff>>10 bitAnd: 16r1F).
		diff := (self partitionedSub: sourceWord>>16 from: destinationWord>>16
						nBits: 5 nPartitions: 3).
		bitCount := bitCount + (diff bitAnd: 16r1F)
							+ (diff>>5 bitAnd: 16r1F)
							+ (diff>>10 bitAnd: 16r1F)]
		ifFalse:
		[diff := (self partitionedSub: sourceWord from: destinationWord
						nBits: 8 nPartitions: 3).
		bitCount := bitCount + (diff bitAnd: 16rFF)
							+ (diff>>8 bitAnd: 16rFF)
							+ (diff>>16 bitAnd: 16rFF)].
	^ destinationWord  "For no effect on dest"