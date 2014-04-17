header access
isWordsOrBytesNonInt: oop
	"Answer true if the contains only indexable words or bytes (no oops). See comment in formatOf:"
	"Note: Excludes CompiledMethods."

	| fmt |
	fmt := self formatOf: oop.
	^ fmt = 6 or: [(fmt >= 8) and: [fmt <= 11]]