instruction decoding
pushConsArrayWithElements: numElements
	"Push Cons Array of size numElements popping numElements items from the stack into the array bytecode."
	self drop: numElements - 1