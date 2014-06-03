object testing
isWeak: oop
	"Answer if the argument has only weak fields that can hold oops. See comment in formatOf:"
	^(self isNonImmediate: oop) and: [self isWeakNonImm: oop]