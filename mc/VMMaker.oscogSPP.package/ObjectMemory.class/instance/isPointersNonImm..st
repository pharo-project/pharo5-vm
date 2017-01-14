header access
isPointersNonImm: oop
	"Answer if the argument has only fields that can hold oops. See comment in formatOf:"

	^(self formatOf: oop) <= self lastPointerFormat