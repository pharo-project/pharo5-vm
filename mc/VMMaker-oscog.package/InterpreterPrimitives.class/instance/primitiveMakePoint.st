arithmetic integer primitives
primitiveMakePoint
	| rcvr argument pt |
	argument := self stackTop.
	rcvr := self stackValue: 1.
	(objectMemory isIntegerObject: rcvr)
		ifTrue: [(objectMemory isIntegerObject: argument)
				ifTrue: [pt := self makePointwithxValue: (objectMemory integerValueOf: rcvr) yValue: (objectMemory integerValueOf: argument)]
				ifFalse: [pt := self makePointwithxValue: (objectMemory integerValueOf: rcvr) yValue: 0.
					"Above may cause GC!"
					objectMemory storePointer: 1 ofObject: pt withValue: (self stackValue: 0)]]
		ifFalse: [(self isFloatObject: rcvr)
				ifFalse: [^ self success: false].
			pt := self makePointwithxValue: 0 yValue: 0.
			"Above may cause GC!"
			objectMemory storePointer: 0 ofObject: pt withValue: (self stackValue: 1).
			objectMemory storePointer: 1 ofObject: pt withValue: (self stackValue: 0)].

	self pop: 2 thenPush: pt