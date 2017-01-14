header access
isBytesNonImm: oop
	"Answer true if the argument contains indexable bytes. See comment in formatOf:"
	"Note: Includes CompiledMethods."

	^(self formatOf: oop) >= self firstByteFormat