trampolines
ceNewHashOf: anObject
	<api>
	<option: #SpurObjectMemory>
	"We know anObject has not a hash yet (or this trampoline would not be called.
	 Sets the hash, then answers it as a smallinteger"
	self assert: ((objectMemory isNonImmediate: anObject)
				and: [(objectMemory rawHashBitsOf: anObject) = 0]).
	^objectMemory integerObjectOf: (objectMemory newHashBitsOf: anObject)