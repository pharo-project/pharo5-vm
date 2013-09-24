control primitives
primitiveDoPrimitiveWithArgs
	| argumentArray arraySize index primIdx |
	argumentArray := self stackTop.
	(objectMemory isArray: argumentArray) ifFalse: [^self primitiveFail].
	arraySize := objectMemory fetchWordLengthOf: argumentArray.
	self success: (self roomToPushNArgs: arraySize).

	primIdx := self stackIntegerValue: 1.
	self successful ifFalse: [^self primitiveFail]. "invalid args"

	primitiveFunctionPointer := self functionPointerFor: primIdx inClass: nil.
	primitiveFunctionPointer = 0 ifTrue:
		[^self primitiveFail].

	"Pop primIndex and argArray, then push args in place..."
	self pop: 2.
	argumentCount := arraySize.
	index := 1.
	[index <= argumentCount] whileTrue:
		[self push: (objectMemory fetchPointer: index - 1 ofObject: argumentArray).
		 index := index + 1].

	self isPrimitiveFunctionPointerAnIndex ifTrue:
		[self externalQuickPrimitiveResponse.
		^nil].
	"We use tempOop instead of pushRemappableOop:/popRemappableOop here because in
	 the Cogit primitiveEnterCriticalSection, primitiveSignal, primitiveResume et al longjmp back
	 to either the interpreter or machine code, depending on the process activated.  So if we're
	 executing one of these primitives control won't actually return here and the matching
	 popRemappableOop: wouldn't occur, potentially overflowing the remap buffer.  While recursion
	 could occur (nil tryPrimitive: 118 withArgs: #(111 #())) it counts as shooting oneself in the foot."
	tempOop := argumentArray. "prim might alloc/gc"
	"Run the primitive (sets primFailCode)"
	self slowPrimitiveResponse.
	self successful ifFalse: "If primitive failed, then restore state for failure code"
		[self pop: arraySize.
		 self pushInteger: primIdx.
		 self push: tempOop.
		 argumentCount := 2].
	tempOop := 0