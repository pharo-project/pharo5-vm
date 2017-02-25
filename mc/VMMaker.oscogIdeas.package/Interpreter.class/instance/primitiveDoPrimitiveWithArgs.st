control primitives
primitiveDoPrimitiveWithArgs
	| argumentArray arraySize index cntxSize primIdx |
	argumentArray := self stackTop.
	arraySize := self numSlotsOf: argumentArray.
	cntxSize := self numSlotsOf: activeContext.
	self success: self stackPointerIndex + arraySize < cntxSize.
	(self isArray: argumentArray) ifFalse: [^ self primitiveFail].

	primIdx := self stackIntegerValue: 1.
	successFlag ifFalse: [^ self primitiveFail]. "invalid args"

	"Pop primIndex and argArray, then push args in place..."
	self pop: 2.
	primitiveIndex := primIdx.
	argumentCount := arraySize.
	index := 1.
	[index <= argumentCount]
		whileTrue: [self push: (self fetchPointer: index - 1 ofObject: argumentArray).
			index := index + 1].

	"Run the primitive (sets successFlag)"
	self pushRemappableOop: argumentArray. "prim might alloc/gc"
	lkupClass := nilObj.
	self primitiveResponse.
	argumentArray := self popRemappableOop.
	successFlag
		ifFalse: ["If primitive failed, then restore state for failure code"
			self pop: arraySize.
			self pushInteger: primIdx.
			self push: argumentArray.
			argumentCount := 2]