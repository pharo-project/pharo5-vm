testing
isSignExtendedFourByteValue: unsigned64BitValue
	"Top 32 bits all the same as the bottom 32 bits' sign bit  implies we can use a sign-extended 4 byte offset."
	^((self cCode: [unsigned64BitValue >>> 32]
			inSmalltalk: [(unsigned64BitValue >> 32) signedIntFromLong]) + 1 bitXor: 1) = (unsigned64BitValue >> 31 bitAnd: 1)