header access
isBytesNonInt: oop
	"Answer true if the argument contains indexable bytes. See comment in formatOf:"
	"Note: Includes CompiledMethods."

	^ (self formatOf: oop)  >= 8