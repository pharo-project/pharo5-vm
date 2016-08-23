object testing
isShortsNonImm: objOop
	"Answer if the argument contains only indexable 16-bit half words (no oops). See comment in formatOf:"

	^(self formatOf: objOop) between: self firstShortFormat and: self firstByteFormat - 1