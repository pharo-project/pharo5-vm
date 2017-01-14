header access
isWordsOrBytesNonImm: oop
	"Answer if the contains only indexable words or bytes (no oops). See comment in formatOf:"
	"Note: Excludes CompiledMethods."

	| fmt |
	fmt := self formatOf: oop.
	^fmt = self firstLongFormat
	  or: [fmt >= self firstByteFormat
		  and: [fmt < self firstCompiledMethodFormat]]