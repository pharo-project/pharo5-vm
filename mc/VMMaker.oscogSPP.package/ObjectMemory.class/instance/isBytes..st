header access
isBytes: oop
	"Answer true if the argument contains indexable bytes. See comment in formatOf:"
	"Note: Includes CompiledMethods."
	^(self isNonIntegerObject: oop) and:[self isBytesNonImm: oop]