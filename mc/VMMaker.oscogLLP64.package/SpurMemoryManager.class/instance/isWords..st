object testing
isWords: oop
	"Answer if the argument contains only indexable words (no oops). See comment in formatOf:"

	^(self isNonImmediate: oop)
	  and: [self isWordsNonImm: oop]