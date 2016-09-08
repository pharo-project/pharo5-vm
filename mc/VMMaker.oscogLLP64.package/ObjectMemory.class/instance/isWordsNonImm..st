header access
isWordsNonImm: oop
	"Answer if the argument contains only indexable words (no oops). See comment in formatOf:"

	^ (self formatOf: oop) = self firstLongFormat