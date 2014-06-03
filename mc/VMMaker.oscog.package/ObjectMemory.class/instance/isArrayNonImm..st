header access
isArrayNonImm: oop
	"Answer true if this is an indexable object with pointer elements, e.g., an array"
	^ (self formatOf: oop) = 2