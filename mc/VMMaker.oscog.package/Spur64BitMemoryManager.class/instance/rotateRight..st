interpreter access
rotateRight: anInteger
	^(self cCode: [anInteger] inSmalltalk: [anInteger bitAnd: 1]) << 63 + (anInteger asUnsignedLong >> 1)