object access primitives
primitiveClass
	| instance |
	instance := self stackTop.
	argumentCount > 0 ifTrue:
		[instance := objectMemory followMaybeForwarded: instance].
	self pop: argumentCount + 1 thenPush: (objectMemory fetchClassOf: instance)