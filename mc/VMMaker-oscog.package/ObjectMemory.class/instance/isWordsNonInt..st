header access
isWordsNonInt: oop
	"Answer true if the argument contains only indexable words (no oops). See comment in formatOf:"

	^ (self formatOf: oop) = 6