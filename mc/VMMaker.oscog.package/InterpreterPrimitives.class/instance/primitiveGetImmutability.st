object access primitives
primitiveGetImmutability
	<option: #IMMUTABILITY>
	| rcvr |
	rcvr := self stackValue: argumentCount.
	self pop: argumentCount + 1 thenPushBool: (objectMemory isOopImmutable: rcvr)