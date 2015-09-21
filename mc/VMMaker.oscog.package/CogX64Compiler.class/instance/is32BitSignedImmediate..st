testing
is32BitSignedImmediate: a64BitUnsignedOperand
	^(a64BitUnsignedOperand >> 31) signedIntFromLong between: -1 and: 0