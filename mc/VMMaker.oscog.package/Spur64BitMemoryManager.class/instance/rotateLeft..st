interpreter access
rotateLeft: anInteger
	^(anInteger >> 63 bitAnd: 1) + ((self cCode: [anInteger] inSmalltalk: [anInteger bitAnd: 16r7FFFFFFFFFFFFFFF]) << 1)