object access primitives
primitiveSomeInstance
	| class instance |
	class := self stackTop.
	instance := self initialInstanceOf: class.
	instance = nilObj
		ifTrue: [self primitiveFail]
		ifFalse: [self pop: argumentCount+1 thenPush: instance]