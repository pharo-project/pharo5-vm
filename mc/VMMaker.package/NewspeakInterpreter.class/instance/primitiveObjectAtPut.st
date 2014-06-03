object access primitives
primitiveObjectAtPut
"Defined for CompiledMethods only"
	| rcvr index newValue |
	newValue := self stackValue: 0.
	index := self stackIntegerValue: 1.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 2.
	(index > 0 and: [index <= ((self literalCountOf: rcvr) + LiteralStart)]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	(self isOopImmutable: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].
	self storePointer: index - 1 ofObject: rcvr withValue: newValue.
	self pop: 3 thenPush: newValue