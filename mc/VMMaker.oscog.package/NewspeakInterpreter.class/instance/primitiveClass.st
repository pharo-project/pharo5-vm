object access primitives
primitiveClass
	| instance |
	instance := self stackTop.
	self pop: argumentCount+1 thenPush: (self fetchClassOf: instance)