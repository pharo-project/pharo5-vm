object access primitives
primitiveGetImmutability
	<option: #IMMUTABILITY>
	| rcvr |
	rcvr := self stackValue: 0.
	self pop: argumentCount + 1 thenPushBool: (objectMemory isOopImmutable: rcvr)