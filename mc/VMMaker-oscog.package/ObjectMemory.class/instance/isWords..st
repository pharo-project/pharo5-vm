header access
isWords: oop
	"Answer true if the argument contains only indexable words (no oops). See comment in formatOf:"

	^(self isNonIntegerObject: oop) and:[self isWordsNonInt: oop]