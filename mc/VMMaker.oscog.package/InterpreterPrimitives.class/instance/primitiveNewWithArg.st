object access primitives
primitiveNewWithArg
	"Allocate a new indexable instance. Fail if the allocation would leave less than lowSpaceThreshold bytes free. May cause a GC."
	| size spaceOkay |
	size := self positive32BitValueOf: self stackTop.
	self cppIf: NewspeakVM
		ifTrue: "For the mirror prims check that the class obj is actually a valid class."
			[(argumentCount < 2
			  or: [self addressCouldBeClassObj: (self stackValue: 1)]) ifFalse:
				[self primitiveFailFor: PrimErrBadArgument]].
	(self successful and: [size >= 0])
		ifTrue:
			[objectMemory hasSpurMemoryManagerAPI
				ifTrue:
					[(objectMemory instantiateClass: (self stackValue: 1) indexableSize: size)
						ifNotNil: [:obj| self pop: argumentCount + 1 thenPush: obj]
						ifNil: [self primitiveFailFor: PrimErrNoMemory]]
				ifFalse:
					[spaceOkay := objectMemory sufficientSpaceToInstantiate: (self stackValue: 1) indexableSize: size.
					 spaceOkay
						ifTrue:
							[self
								pop: argumentCount + 1
								thenPush: (objectMemory instantiateClass: (self stackValue: 1) indexableSize: size)]
						ifFalse:
							[self primitiveFailFor: PrimErrNoMemory]]]
		ifFalse:
			[self primitiveFailFor: PrimErrBadArgument]