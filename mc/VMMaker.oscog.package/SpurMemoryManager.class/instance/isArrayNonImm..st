object testing
isArrayNonImm: oop
	"Answer true if this is an indexable object with pointer elements, e.g., an array"
	^ (self formatOf: oop) = self arrayFormat