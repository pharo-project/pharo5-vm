object testing
isLong64s: oop
	"Answer if the argument contains only indexable 64-bit double words (no oops). See comment in formatOf:"

	^(self isNonImmediate: oop)
	  and: [self isLong64sNonImm: oop]