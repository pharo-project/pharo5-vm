object access primitives
primitiveSlotAtPut
	"Assign a slot in an object.  This numbers all slots from 1, ignoring the distinction between
	 named and indexed inst vars.  In objects with both named and indexed inst vars, the named
	 inst vars precede the indexed ones.  In non-object indexed objects (objects that contain
	 bits, not object references) this primitive assigns a raw integral value at each slot."
	| newValue index rcvr fmt numSlots value badRcvr |
	newValue := self stackTop.
	index := self stackValue: 1.
	rcvr := self stackValue: 2.
	(objectMemory isIntegerObject: index) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	self cppIf: IMMUTABILITY 
		ifTrue: [ badRcvr := objectMemory isOopImmutable: rcvr ]
		ifFalse: [ badRcvr := objectMemory isImmediate: rcvr ].
	badRcvr ifTrue:
		[^self primitiveFailFor: PrimErrBadReceiver].
	fmt := objectMemory formatOf: rcvr.
	index := (objectMemory integerValueOf: index) - 1.

	fmt <= objectMemory lastPointerFormat ifTrue:
		[numSlots := objectMemory numSlotsOf: rcvr.
		 (self asUnsigned: index) < numSlots ifTrue:
			[(objectMemory isContextNonImm: rcvr)
				ifTrue: [self externalInstVar: index ofContext: rcvr put: newValue]
				ifFalse: [objectMemory storePointer: index ofObject: rcvr withValue: newValue].
			 self pop: argumentCount + 1 thenPush: newValue.
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].

	value := self positiveMachineIntegerValueOf: newValue.
	self failed ifTrue:
		[primFailCode := PrimErrBadArgument.
		^0].

	fmt >= objectMemory firstByteFormat ifTrue:
		[fmt >= objectMemory firstCompiledMethodFormat ifTrue:
			[^self primitiveFailFor: PrimErrUnsupported].
		 (self asUnsigned: value) > 16rFF ifTrue:
			[^self primitiveFailFor: PrimErrBadArgument].
		 numSlots := objectMemory numBytesOfBytes: rcvr.
		 (self asUnsigned: index) < numSlots ifTrue:
			[objectMemory storeByte: index ofObject: rcvr withValue: value.
			 self pop: argumentCount + 1 thenPush: newValue.
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].

	(objectMemory hasSpurMemoryManagerAPI
	 and: [fmt >= objectMemory firstShortFormat]) ifTrue:
		[(self asUnsigned: value) > 16rFFFF ifTrue:
			[^self primitiveFailFor: PrimErrBadArgument].
		 numSlots := objectMemory num16BitUnitsOf: rcvr.
		 (self asUnsigned: index) < numSlots ifTrue:
			[objectMemory storeShort16: index ofObject: rcvr withValue: value.
			 self pop: argumentCount + 1 thenPush: newValue.
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].

	(objectMemory bytesPerOop = 8
	 and: [fmt = objectMemory sixtyFourBitIndexableFormat]) ifTrue:
		[numSlots := objectMemory num64BitUnitsOf: rcvr.
		 (self asUnsigned: index) < numSlots ifTrue:
			[objectMemory storeLong64: index ofObject: rcvr withValue: value.
			 self pop: argumentCount + 1 thenPush: newValue.
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].

	fmt >= objectMemory firstLongFormat ifTrue:
		[(objectMemory wordSize > 4
		  and: [(self asUnsigned: value) > 16rFFFFFFFF]) ifTrue:
			[^self primitiveFailFor: PrimErrBadArgument].
		 numSlots := objectMemory num32BitUnitsOf: rcvr.
		 (self asUnsigned: index) < numSlots ifTrue:
			[objectMemory storeLong32: index ofObject: rcvr withValue: value.
			 self pop: argumentCount + 1 thenPush: newValue.
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].

	^self primitiveFailFor: PrimErrBadReceiver