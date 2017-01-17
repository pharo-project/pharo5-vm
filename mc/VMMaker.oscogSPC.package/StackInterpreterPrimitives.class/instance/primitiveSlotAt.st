object access primitives
primitiveSlotAt
	"Answer a slot in an object.  This numbers all slots from 1, ignoring the distinction between
	 named and indexed inst vars.  In objects with both named and indexed inst vars, the named
	 inst vars precede the indexed ones.  In non-object indexed objects (objects that contain
	 bits, not object references) this primitive answers the raw integral value at each slot. 
	 e.g. for Strings it answers the character code, not the Character object at each slot."
	| index rcvr fmt numSlots |
	index := self stackTop.
	rcvr := self stackValue: 1.
	(objectMemory isIntegerObject: index) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	(objectMemory isImmediate: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrBadReceiver].
	fmt := objectMemory formatOf: rcvr.
	index := (objectMemory integerValueOf: index) - 1.

	fmt <= objectMemory lastPointerFormat ifTrue:
		[numSlots := objectMemory numSlotsOf: rcvr.
		 (self asUnsigned: index) < numSlots ifTrue:
			[| value numLiveSlots |
			 (objectMemory isContextNonImm: rcvr)
				ifTrue:
					[self externalWriteBackHeadFramePointers.
					 numLiveSlots := (self stackPointerForMaybeMarriedContext: rcvr) + CtxtTempFrameStart.
					 value := (self asUnsigned: index) < numLiveSlots
								ifTrue: [self externalInstVar: index ofContext: rcvr]
								ifFalse: [objectMemory nilObject]]
				ifFalse:
					[value := objectMemory fetchPointer: index ofObject: rcvr].
			 self pop: argumentCount + 1 thenPush: value.
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].

	fmt >= objectMemory firstByteFormat ifTrue:
		[fmt >= objectMemory firstCompiledMethodFormat ifTrue:
			[^self primitiveFailFor: PrimErrUnsupported].
		 numSlots := objectMemory numBytesOfBytes: rcvr.
		 (self asUnsigned: index) < numSlots ifTrue:
			[self pop: argumentCount + 1 thenPushInteger: (objectMemory fetchByte: index ofObject: rcvr).
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].

	(objectMemory hasSpurMemoryManagerAPI
	 and: [fmt >= objectMemory firstShortFormat]) ifTrue:
		[numSlots := objectMemory num16BitUnitsOf: rcvr.
		 (self asUnsigned: index) < numSlots ifTrue:
			[self pop: argumentCount + 1 thenPushInteger: (objectMemory fetchUnsignedShort16: index ofObject: rcvr).
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].

	fmt = objectMemory sixtyFourBitIndexableFormat ifTrue:
		[numSlots := objectMemory num64BitUnitsOf: rcvr.
		 (self asUnsigned: index) < numSlots ifTrue:
			[self pop: argumentCount + 1
				thenPush: (self positive64BitIntegerFor: (objectMemory fetchLong64: index ofObject: rcvr)).
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].

	fmt >= objectMemory firstLongFormat ifTrue:
		[numSlots := objectMemory num32BitUnitsOf: rcvr.
		 (self asUnsigned: index) < numSlots ifTrue:
			[self pop: argumentCount + 1
				thenPush: (self positive32BitIntegerFor: (objectMemory fetchLong32: index ofObject: rcvr)).
			 ^0].
		 ^self primitiveFailFor: PrimErrBadIndex].

	^self primitiveFailFor: PrimErrBadReceiver