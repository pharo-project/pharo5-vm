object access primitives
primitiveGetImmutability
	self cppIf: #IMMUTABILITY
		ifTrue:
			[| rcvr |
			 rcvr := self stackValue: 0.
			 self pop: argumentCount + 1 thenPushBool: (objectMemory isOopImmutable: rcvr)]
		ifFalse:
			[self primitiveFailFor: PrimErrUnsupported]