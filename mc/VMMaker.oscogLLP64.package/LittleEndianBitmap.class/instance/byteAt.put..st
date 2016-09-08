accessing
byteAt: byteAddress put: byte
	"Insert a byte into a Bitmap (little-endian version).  N.B. Signedness will be lost since byteAt: answers non-negative values.
	 We can add a signedByteAt: if needed."
	| value longWord shift lowBits longAddr |
	(byte < 0 or:[byte > 255]) ifTrue:[^self errorImproperStore].
	value := byte < 0
				ifTrue: [byte < 128 ifTrue:
							[self errorImproperStore].
						16rFF bitAnd: byte]
				ifFalse: [16rFF < byte ifTrue:
							[self errorImproperStore].
						byte].
	lowBits := byteAddress - 1 bitAnd: 3.
	longWord := self at: (longAddr := (byteAddress - 1 - lowBits) // 4 + 1).
	shift := lowBits * 8.
	longWord := longWord
				- (longWord bitAnd: (16rFF bitShift: shift)) 
				+ (value bitShift: shift).
	self at: longAddr put: longWord.
	^byte