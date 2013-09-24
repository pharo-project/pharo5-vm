immediates
isInRangeCharacterCode: characterCode
	^characterCode >= 0 and: [characterCode < (2 raisedTo: 30)]