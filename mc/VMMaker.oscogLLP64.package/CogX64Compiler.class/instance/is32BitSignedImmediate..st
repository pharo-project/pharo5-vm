testing
is32BitSignedImmediate: a64BitUnsignedOperand
	"Top 32 bits all the same as the bottom 32 bits' sign bit implies we can use a sign-extended 4 byte offset."
	^self cCode: [(self cCoerceSimple: a64BitUnsignedOperand to: #int) = (self cCoerceSimple: a64BitUnsignedOperand to: #sqLong)]
		inSmalltalk: [((a64BitUnsignedOperand >> 32) signedIntFromLong + 1 bitXor: 1) = (a64BitUnsignedOperand >> 31 bitAnd: 1)]