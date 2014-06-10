object access primitives
primitiveSomeInstance
	| class instance |
	class := self stackTop.
	instance := objectMemory initialInstanceOf: class.
	instance
		ifNil: [self primitiveFail]
		ifNotNil: [self pop: argumentCount+1 thenPush: instance]