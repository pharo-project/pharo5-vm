interpreter access
rotateRight: anInteger
	^(self cCode: [anInteger] inSmalltalk: [anInteger bitAnd: 1]) << 63 + (anInteger asUnsignedInteger >> 1)