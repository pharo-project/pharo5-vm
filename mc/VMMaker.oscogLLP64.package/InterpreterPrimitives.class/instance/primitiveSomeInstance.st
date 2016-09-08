object access primitives
primitiveSomeInstance
	| class instance |
	class := self stackTop.
	NewspeakVM ifTrue: "For the mirror prims check that the class obj is actually a valid class."
		[(argumentCount < 1
		  or: [(objectMemory isNonImmediate: class)
			  and: [self objCouldBeClassObj: class]]) ifFalse:
			[^self primitiveFailFor: PrimErrBadArgument]].
	instance := objectMemory initialInstanceOf: class.
	instance
		ifNil: [self primitiveFail]
		ifNotNil: [self pop: argumentCount+1 thenPush: instance]