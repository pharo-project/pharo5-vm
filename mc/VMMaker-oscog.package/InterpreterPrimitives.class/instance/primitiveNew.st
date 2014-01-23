object access primitives
primitiveNew
	"Allocate a new fixed-size instance. Fail if the allocation would leave less than lowSpaceThreshold bytes free. May cause a GC."
	| spaceOkay |
	"The following may cause GC!"
	spaceOkay := objectMemory sufficientSpaceToInstantiate: self stackTop indexableSize: 0.
	spaceOkay	ifTrue: [self
					pop: argumentCount + 1
					thenPush: (objectMemory instantiateClass: self stackTop indexableSize: 0)]
		ifFalse: [self primitiveFailFor: PrimErrNoMemory]