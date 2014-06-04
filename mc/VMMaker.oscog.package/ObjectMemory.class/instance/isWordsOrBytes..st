header access
isWordsOrBytes: oop
	"Answer if the contains only indexable words or bytes (no oops). See comment in formatOf:"
	"Note: Excludes CompiledMethods."
	^(self isNonIntegerObject: oop) and: [self isWordsOrBytesNonImm: oop]