object testing
isPointersNonImm: objOop
	"Answer if the argument has only fields that can hold oops. See comment in formatOf:"
	^(self formatOf: objOop) <= self lastPointerFormat