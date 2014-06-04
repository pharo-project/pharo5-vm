control primitives
primitiveDoPrimitiveWithArgs
	| argumentArray arraySize index cntxSize primIdx |
	argumentArray := self stackTop.
	arraySize := self fetchWordLengthOf: argumentArray.
	cntxSize := self fetchWordLengthOf: activeContext.
	self success: self stackPointerIndex + arraySize < cntxSize.
	(self isArray: argumentArray) ifFalse: [^ self primitiveFail].

	primIdx := self stackIntegerValue: 1.
	self successful ifFalse: [^ self primitiveFail]. "invalid args"

	primitiveFunctionPointer := self functionPointerFor: primIdx inClass: nil.
	primitiveFunctionPointer = 0 ifTrue:
		[^self primitiveFail].

	"Pop primIndex and argArray, then push args in place..."
	self pop: 2.
	argumentCount := arraySize.
	index := 1.
	[index <= argumentCount] whileTrue:
		[self push: (self fetchPointer: index - 1 ofObject: argumentArray).
		 index := index + 1].

	self isPrimitiveFunctionPointerAnIndex ifTrue:
		[self externalQuickPrimitiveResponse.
		^nil].

	"Run the primitive (sets successFlag)"
	self pushRemappableOop: argumentArray. "prim might alloc/gc"
	lkupClass := nilObj.
	"Run the primitive (sets primFailCode)"
	self slowPrimitiveResponse.
	argumentArray := self popRemappableOop.
	self successful ifFalse:
		["If primitive failed, then restore state for failure code"
		self pop: arraySize.
		self pushInteger: primIdx.
		self push: argumentArray.
		argumentCount := 2]