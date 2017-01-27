trampolines
ceNewHashOf: anObject
	<api>
	<option: #SistaVM>
	"We know anObject has not a hash yet (or this trampoline would not be called.
	 Sets the hash, then answers it as a smallinteger"
	^ objectMemory integerObjectOf: (objectMemory newHashBitsOf: anObject)