accessing
byteAt: byteAddress
	"Extract a byte from a Bitmap (little-endian version)"
	| lowBits |
	lowBits := byteAddress - 1 bitAnd: 3.
	^((self at: byteAddress - 1 - lowBits // 4 + 1)
		bitShift: lowBits * -8)
		bitAnd: 16rFF