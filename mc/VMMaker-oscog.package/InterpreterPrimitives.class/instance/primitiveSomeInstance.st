object access primitives
primitiveSomeInstance
	| class instance |
	class := self stackTop.
	instance := objectMemory initialInstanceOf: class.
	instance = objectMemory nilObject
		ifTrue: [self primitiveFail]
		ifFalse: [self pop: argumentCount+1 thenPush: instance]