inflating
zipNextBits: n
	| bits byte |
	<inline: true>
	[zipBitPos < n] whileTrue:[
		byte := zipSource at: (zipSourcePos := zipSourcePos + 1).
		zipBitBuf := zipBitBuf + (byte << zipBitPos).
		zipBitPos := zipBitPos + 8].
	bits := zipBitBuf bitAnd: (1 << n)-1.
	zipBitBuf := zipBitBuf >> n.
	zipBitPos := zipBitPos - n.
	^bits