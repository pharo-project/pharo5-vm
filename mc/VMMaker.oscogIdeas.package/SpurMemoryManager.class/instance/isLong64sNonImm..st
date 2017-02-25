object testing
isLong64sNonImm: objOop
	"Answer if the argument contains only indexable 64-bit double words (no oops). See comment in formatOf:"

	^(self formatOf: objOop) = self sixtyFourBitIndexableFormat