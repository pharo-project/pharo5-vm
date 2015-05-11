object access primitives
primitiveClass
	| instance |
	instance := self stackTop.
	NewspeakVM
		ifTrue:
			[argumentCount > 0 ifTrue:
				[instance := objectMemory followMaybeForwarded: instance].
			 self pop: argumentCount+1 thenPush: (objectMemory fetchClassOf: instance)]
		ifFalse:
			[self assert argumentCount = 0.
			 self pop: 1 thenPush: (objectMemory fetchClassOf: instance)]