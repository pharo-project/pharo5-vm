object access primitives
primitiveNew
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			["Allocate a new fixed-size instance.  Fail if the allocation would leave
			  less than lowSpaceThreshold bytes free. This *will not* cause a GC :-)"
			(objectMemory instantiateClass: self stackTop)
				ifNotNil: [:obj| self pop: argumentCount + 1 thenPush: obj]
				ifNil: [self primitiveFailFor: PrimErrNoMemory]]
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