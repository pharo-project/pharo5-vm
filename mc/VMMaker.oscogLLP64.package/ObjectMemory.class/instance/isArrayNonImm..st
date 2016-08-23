header access
isArrayNonImm: oop
	<api>
	"Answer if this is an indexable object with pointer elements, e.g., an array"
	^ (self formatOf: oop) = 2