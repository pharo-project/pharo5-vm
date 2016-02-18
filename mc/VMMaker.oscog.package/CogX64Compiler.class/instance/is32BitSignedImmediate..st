testing
is32BitSignedImmediate: a64BitUnsignedOperand
	^self cCode: [(self cCoerceSimple: a64BitUnsignedOperand to: #int) = (self cCoerceSimple: a64BitUnsignedOperand to: #long)]
		inSmalltalk: [((a64BitUnsignedOperand >> 32) signedIntFromLong between: -1 and: 0)
					and: [(a64BitUnsignedOperand >> 31) signedIntFromLong between: -1 and: 0]]