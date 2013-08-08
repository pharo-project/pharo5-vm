object access primitives
primitiveNextInstance
	| object instance |
	object := self stackTop.
	(self isIntegerObject: object) ifTrue:
		[^self primitiveFail].
	instance := self instanceAfter: object.
	instance = nilObj ifTrue:
		[^self primitiveFail].
	self pop: argumentCount+1 thenPush: instance