object access primitives
primitiveSetImmutability
	<option: #IMMUTABILITY>
	| rcvr wasImmutable |
	 rcvr := self stackValue: 1.
	 (objectMemory isImmediate: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrBadReceiver].
	 wasImmutable := objectMemory isObjImmutable: rcvr.
	 self stackTop = objectMemory trueObject
		ifTrue:
			[(self canBeImmutable: rcvr) ifFalse:
				[^self primitiveFailFor: PrimErrInappropriate].
			  objectMemory setIsImmutableOf: rcvr to: true]
		ifFalse: [
	self stackTop = objectMemory falseObject
		ifTrue: [objectMemory setIsImmutableOf: rcvr to: false]
	 	ifFalse:
			[^self primitiveFailFor: PrimErrBadArgument]].
	 self pop: argumentCount + 1 thenPushBool: wasImmutable