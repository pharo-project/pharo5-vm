object access primitives
primitiveNewWithArg
	"Allocate a new indexable instance. Fail if the allocation would leave less than lowSpaceThreshold bytes free. May cause a GC."
	| size spaceOkay instSpec |
	NewspeakVM ifTrue: "For the mirror prims check that the class obj is actually a valid class."
		[(argumentCount < 2
		  or: [self addressCouldBeClassObj: (self stackValue: 1)]) ifFalse:
			[^self primitiveFailFor: PrimErrBadArgument]].
	size := self positiveMachineIntegerValueOf: self stackTop.
	self successful ifFalse:"positiveMachineIntegerValueOf: succeeds only for non-negative integers."
		[^self primitiveFailFor: PrimErrBadArgument].
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[(objectMemory instantiateClass: (self stackValue: 1) indexableSize: size)
				ifNotNil: [:obj| self pop: argumentCount + 1 thenPush: obj]
				ifNil: [instSpec := objectMemory instSpecOfClass: (self stackValue: 1).
					  self primitiveFailFor: (((objectMemory isIndexableFormat: instSpec)
											and: [(objectMemory isCompiledMethodFormat: instSpec) not])
												ifTrue: [PrimErrNoMemory]
												ifFalse: [PrimErrBadReceiver])]]
		ifFalse:
			[spaceOkay := objectMemory sufficientSpaceToInstantiate: (self stackValue: 1) indexableSize: size.
			 spaceOkay
				ifTrue:
					[self
						pop: argumentCount + 1
						thenPush: (objectMemory instantiateClass: (self stackValue: 1) indexableSize: size)]
				ifFalse:
					[self primitiveFailFor: PrimErrNoMemory]]