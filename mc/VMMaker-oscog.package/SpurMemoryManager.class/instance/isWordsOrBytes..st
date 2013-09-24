object testing
isWordsOrBytes: oop
	^(self isNonImmediate: oop)
	  and: [self isWordsOrBytesNonImm: oop]