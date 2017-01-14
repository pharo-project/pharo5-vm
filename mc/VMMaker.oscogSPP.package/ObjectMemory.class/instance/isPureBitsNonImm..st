object format
isPureBitsNonImm: objOop
	"Answer if the argument contains only indexable words (no oops). See comment in formatOf:"

	^self isPureBitsFormat: (self formatOf: objOop)