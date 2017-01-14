immediates
imageFormatVersion
	"Return a magic constant that changes when the image format changes.
	 Since the image reading code uses this to detect byte ordering, one
	 must avoid version numbers that are invariant under byte reversal.
	 N.B. Bit 4 (=16) is the isSpur bit"

	"^68019" "The first 64-bit Spur format, which unfortunately chose SmallFloat64's tag to be 3."
	^68021