object access primitives
primitiveSetImmutability
	| rcvr boolean wasImmutable |
	rcvr := self stackValue: 1.
	(objectMemory isImmediate: rcvr) ifTrue: [ ^ self primitiveFailFor: PrimErrInappropriate ].
	boolean := self booleanValueOf: self stackTop.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	boolean ifTrue: 
		[ (self canBeImmutable: rcvr) ifFalse: [ ^ self primitiveFailFor: PrimErrInappropriate ] ]. 
	wasImmutable := (objectMemory isOopImmutable: rcvr)
		ifTrue: [ TrueObject ]
		ifFalse: [ FalseObject ].
	objectMemory setIsImmutableOf: rcvr to: boolean.
	self pop: argumentCount thenPush: (self splObj: wasImmutable)