accessing
unsignedByteAt: byteAddress put: byte
	"Insert a byte into a Bitmap (little-endian version)"
	| longWord shift lowBits longAddr |
	(byte < 0 or:[byte > 255]) ifTrue:[^self errorImproperStore].
	lowBits := byteAddress - 1 bitAnd: 3.
	longWord := self at: (longAddr := (byteAddress - 1 - lowBits) // 4 + 1).
	shift := lowBits * 8.
	longWord := longWord
				- (longWord bitAnd: (16rFF bitShift: shift)) 
				+ (byte bitShift: shift).
	self at: longAddr put: longWord.
	^byte