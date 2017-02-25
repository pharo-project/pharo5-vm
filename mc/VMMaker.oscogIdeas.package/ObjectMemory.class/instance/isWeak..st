header access
isWeak: oop
	"Answer true if the argument has only weak fields that can hold oops. See comment in formatOf:"
	^(self isNonIntegerObject: oop) and: [self isWeakNonImm: oop]