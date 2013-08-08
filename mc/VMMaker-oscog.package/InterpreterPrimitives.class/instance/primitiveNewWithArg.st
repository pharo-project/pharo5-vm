object access primitives
primitiveNewWithArg
	"Allocate a new indexable instance. Fail if the allocation would leave less than lowSpaceThreshold bytes free. May cause a GC."
	| size spaceOkay |
	size := self positive32BitValueOf: self stackTop.
	(self successful and: [size >= 0])
		ifTrue:
			[spaceOkay := objectMemory sufficientSpaceToInstantiate: (self stackValue: 1) indexableSize: size.
			 spaceOkay ifTrue:
					[self
						pop: argumentCount + 1
						thenPush: (objectMemory instantiateClass: (self stackValue: 1) indexableSize: size)]
				ifFalse:
					[self primitiveFailFor: PrimErrNoMemory]]
		ifFalse:
			[self primitiveFailFor: PrimErrBadArgument]