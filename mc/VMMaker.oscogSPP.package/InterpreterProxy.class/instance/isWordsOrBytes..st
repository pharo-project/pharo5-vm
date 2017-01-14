testing
isWordsOrBytes: oop
	^(self isBytes: oop) or:[self isWords: oop]