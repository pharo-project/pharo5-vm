object access primitives
primitiveAdoptInstance
	"Primitive. Change the class of the argument to make it an instance of the receiver
	 given that the format of the receiver matches the format of the argument's class.
	 Fail if receiver or argument are SmallIntegers, or the receiver is an instance of a
	 compact class and the argument isn't, or when the argument's class is compact and
	 the receiver isn't, or when the format of the receiver is different from the format of
	 the argument's class, or when the arguments class is fixed and the receiver's size
	 differs from the size that an instance of the argument's class should have."
	| rcvr arg err |

	arg := self stackObjectValue: 0.
	rcvr := self stackObjectValue: 1.

	err := self changeClassOf: arg to: rcvr.
	err = 0
		ifTrue: ["Flush at cache because rcvr's class has changed."
				self flushAtCache.
				self pop: self methodArgumentCount]
		ifFalse: [self primitiveFail].
	^nil