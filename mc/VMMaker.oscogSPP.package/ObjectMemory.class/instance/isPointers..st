header access
isPointers: oop
	"Answer true if the argument has only fields that can hold oops. See comment in formatOf:"

	^(self isNonIntegerObject: oop) and:[self isPointersNonImm: oop]