object testing
isShorts: oop
	"Answer if the argument contains only indexable 16-bit half words (no oops). See comment in formatOf:"

	^(self isNonImmediate: oop)
	  and: [self isShortsNonImm: oop]