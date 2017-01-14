object testing
isWordsOrBytesNonImm: objOop
	"Answer if the contains only indexable words or bytes (no oops). See comment in formatOf:"
	"Note: Excludes CompiledMethods."
	^self isPureBitsFormat: (self formatOf: objOop)