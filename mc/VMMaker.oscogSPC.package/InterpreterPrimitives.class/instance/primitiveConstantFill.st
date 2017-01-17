sound primitives
primitiveConstantFill
	"Fill the receiver, which must be an indexable non-pointer
	 object, with the given integer value."
	objectMemory hasSpurMemoryManagerAPI
		ifTrue: [self primitiveConstantFillSpur]
		ifFalse: [self primitiveConstantFillV3]