object access primitives
primitiveChangeClass
	"Primitive.  Change the class of the receiver into the class of the argument given that
	 the format of the receiver matches the format of the argument's class.  Fail if the
	 receiver or argument are SmallIntegers, or the receiver is an instance of a compact
	 class and the argument isn't, or when the argument's class is compact and the receiver
	 isn't, or when the format of the receiver is different from the format of the argument's
	 class, or when the arguments class is fixed and the receiver's size differs from the size
	 that an instance of the argument's class should have."
	| arg rcvr argClass err |
	arg := self stackObjectValue: 0.
	rcvr := self stackObjectValue: 1.
	self successful ifFalse:[^nil].
	argClass := objectMemory fetchClassOfNonImm: arg.
	err := objectMemory changeClassOf: rcvr to: argClass.
	err = 0
		ifTrue: ["Flush at cache because rcvr's class has changed."
				self flushAtCache.
				self pop: self methodArgumentCount]
		ifFalse: [self primitiveFailFor: err].
	^nil