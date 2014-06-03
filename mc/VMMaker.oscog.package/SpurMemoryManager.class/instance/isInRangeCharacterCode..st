immediates
isInRangeCharacterCode: characterCode
	^characterCode between: 0 and: (1 << 30) - 1