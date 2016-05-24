control primitives
primitiveDoPrimitiveWithArgs
	"Implement either ProtoObject>>tryPrimitive: primIndex withArgs: argArray
	 or Context>>receiver: anObject tryPrimitive: primIndex withArgs: argArray.
	 If this primitive fails, arrange that its error code is a negative integer, to
	 distinguish between this failing and the primitive it invokes failing."
	| argumentArray arraySize index primIdx savedNumArgs rcvr |
	(argumentCount between: 2 and: 3) ifFalse:
		[^self primitiveFailFor: PrimErrUnsupported negated].
	argumentArray := self stackTop.
	primIdx := self stackValue: 1.
	((objectMemory isArray: argumentArray)
	 and: [objectMemory isIntegerObject: primIdx]) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument negated].
	arraySize := objectMemory numSlotsOf: argumentArray.
	(self roomToPushNArgs: arraySize) ifFalse:
		[^self primitiveFailFor: PrimErrLimitExceeded negated].

	primIdx := objectMemory integerValueOf: primIdx.
	primitiveFunctionPointer := self functionPointerFor: primIdx inClass: nil.
	primitiveFunctionPointer = 0 ifTrue:
		[primitiveFunctionPointer := #primitiveDoPrimitiveWithArgs.
		 ^self primitiveFailFor: PrimErrBadIndex negated].

	"Pop primIndex and argArray, then push args in place..."
	(savedNumArgs := argumentCount) = 3
		ifTrue: "...and receiver if the three arg form"
			[tempOop2 := self stackValue: 4. "actual receiver"
			 rcvr := self stackValue: 3. "receiver for primitive"
			 (objectMemory isOopForwarded: rcvr) ifTrue:
				[rcvr := objectMemory followForwarded: rcvr].
			 self pop: 4; push: rcvr] "use first arg as receiver"
		ifFalse:
			[self pop: 2].
	argumentCount := arraySize.
	index := 1.
	[index <= argumentCount] whileTrue:
		[self push: (objectMemory fetchPointer: index - 1 ofObject: argumentArray).
		 index := index + 1].

	self isPrimitiveFunctionPointerAnIndex ifTrue:
		[self externalQuickPrimitiveResponse.
		 tempOop2 := 0.
		^nil].
	"We use tempOop instead of pushRemappableOop:/popRemappableOop here because in
	 the Cogit primitiveEnterCriticalSection, primitiveSignal, primitiveResume et al longjmp back
	 to either the interpreter or machine code, depending on the process activated.  So if we're
	 executing one of these primitives, control won't actually return here and the matching
	 popRemappableOop: wouldn't occur, potentially overflowing the remap buffer.
	 Note that while recursion could occur (nil tryPrimitive: 118 withArgs: #(118 #(110 #())))
	 it counts as shooting oneself in the foot."
	tempOop := argumentArray. "prim might alloc/gc"

	"Run the primitive (sets primFailCode)"
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[tempOop3 := newMethod.
			 newMethod := objectMemory integerObjectOf: primIdx.
			 self slowPrimitiveResponse.
			 newMethod := tempOop3.
			 tempOop3 := 0]
		ifFalse:
			[self slowPrimitiveResponse].

	self successful ifFalse: "If primitive failed, then restore state for failure code"
		[self pop: arraySize.
		 savedNumArgs = 3 ifTrue:
			[rcvr := self stackTop.
			 self stackTopPut: tempOop2.
			 self push: rcvr].
		 self pushInteger: primIdx.
		 self push: tempOop.
		 primitiveFunctionPointer := #primitiveDoPrimitiveWithArgs.
		 argumentCount := savedNumArgs].
	tempOop := tempOop2 := 0