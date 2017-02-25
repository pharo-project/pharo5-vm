header access
isWords: oop
	"Answer if the argument contains only indexable words (no oops). See comment in formatOf:"

	^(self isNonIntegerObject: oop) and: [self isWordsNonImm: oop]