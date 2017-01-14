send bytecodes
ensureReceiverUnforwarded
	"To maintain the invariant that all receivers are unforwarded we need an explicit
	 read barrier in the super send cases."
	(objectMemory isOopForwarded: (self internalStackValue: argumentCount)) ifTrue:
		[self internalStackValue: argumentCount
			put: (objectMemory followForwarded: (self internalStackValue: argumentCount))]