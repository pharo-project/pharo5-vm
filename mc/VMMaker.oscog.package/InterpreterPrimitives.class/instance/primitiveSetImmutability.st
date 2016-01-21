object access primitives
primitiveSetImmutability
	<option: #IMMUTABILITY>
	| rcvr boolean wasImmutable |
	rcvr := self stackValue: 1.
	(objectMemory isImmediate: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrBadReceiver].
	boolean := self booleanValueOf: self stackTop.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	boolean ifTrue: 
		[(self canBeImmutable: rcvr) ifFalse:
			[^self primitiveFailFor: PrimErrInappropriate]]. 
	wasImmutable := objectMemory booleanObjectOf: (objectMemory isOopImmutable: rcvr).
	objectMemory setIsImmutableOf: rcvr to: boolean.
	self pop: argumentCount + 1 thenPush: wasImmutable