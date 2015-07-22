object access primitives
primitiveNew
	NewspeakVM ifTrue: "For the mirror prims check that the class obj is actually a valid class."
		[(argumentCount < 1
		  or: [self objCouldBeClassObj: self stackTop]) ifFalse:
			[^self primitiveFailFor: PrimErrBadArgument]].
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			["Allocate a new fixed-size instance.  Fail if the allocation would leave
			  less than lowSpaceThreshold bytes free. This *will not* cause a GC :-)"
			(objectMemory instantiateClass: self stackTop)
				ifNotNil: [:obj| self pop: argumentCount + 1 thenPush: obj]
				ifNil: [self primitiveFailFor: ((objectMemory isFixedSizePointerFormat: (objectMemory instSpecOfClass: self stackTop))
											ifTrue: [PrimErrNoMemory]
											ifFalse: [PrimErrBadReceiver])]]
		ifFalse:
			["Allocate a new fixed-size instance. Fail if the allocation would leave
			  less than lowSpaceThreshold bytes free. May cause a GC."
			| spaceOkay |
			"The following may cause GC! Use var for result to permit inlining."
			spaceOkay := objectMemory
								sufficientSpaceToInstantiate: self stackTop
								indexableSize: 0.
			spaceOkay
				ifTrue:
					[self
						pop: argumentCount + 1
						thenPush: (objectMemory
									instantiateClass: self stackTop
									indexableSize: 0)]
				ifFalse: [self primitiveFailFor: PrimErrNoMemory]]