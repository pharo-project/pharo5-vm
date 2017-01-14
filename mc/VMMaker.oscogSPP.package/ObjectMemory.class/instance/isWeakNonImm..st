header access
isWeakNonImm: oop
	"Answer if the argument has only weak fields that can hold oops. See comment in formatOf:"
	^(self formatOf: oop) = self weakArrayFormat