object testing
isPointers: oop
	"Answer if the argument has only fields that can hold oops. See comment in formatOf:"

	^(self isNonImmediate: oop) and: [self isPointersNonImm: oop]