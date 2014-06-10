object access primitives
primitiveNextInstance
	| object instance |
	object := self stackTop.
	instance := self instanceAfter: object.
	instance = nilObj
		ifTrue: [self primitiveFail]
		ifFalse: [self pop: argumentCount+1 thenPush: instance]