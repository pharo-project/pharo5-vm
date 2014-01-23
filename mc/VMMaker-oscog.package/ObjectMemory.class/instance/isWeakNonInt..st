header access
isWeakNonInt: oop
	"Answer true if the argument has only weak fields that can hold oops. See comment in formatOf:"
	^ (self formatOf: oop) = 4