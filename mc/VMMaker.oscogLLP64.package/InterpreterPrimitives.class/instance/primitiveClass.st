object access primitives
primitiveClass
	| instance |
	instance := self stackTop.
	(argumentCount > 0
	 and: [objectMemory isOopForwarded: instance])
		ifTrue:
			[self primitiveFail]
		ifFalse:
			[self pop: argumentCount + 1 thenPush: (objectMemory fetchClassOf: instance)]