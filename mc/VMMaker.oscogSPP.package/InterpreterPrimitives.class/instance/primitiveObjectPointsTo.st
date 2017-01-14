object access primitives
primitiveObjectPointsTo
	| rcvr thang lastField |
	thang := self stackTop.
	rcvr := self stackValue: 1.
	(objectMemory isIntegerObject: rcvr) ifTrue:
		[^self pop: 2 thenPushBool: false].

	lastField := self lastPointerOf: rcvr.
	objectMemory baseHeaderSize to: lastField by: objectMemory bytesPerOop do:
		[:i |
		(objectMemory longAt: rcvr + i) = thang ifTrue:
			[^self pop: 2 thenPushBool: true]].
	self pop: 2 thenPushBool: false