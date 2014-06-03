arithmetic integer primitives
primitiveMakePoint
	| rcvr argument pt |
	argument := self stackTop.
	rcvr := self stackValue: 1.
	(self isIntegerObject: rcvr)
		ifTrue: [(self isIntegerObject: argument)
				ifTrue: [pt := self makePointwithxValue: (self integerValueOf: rcvr) yValue: (self integerValueOf: argument)]
				ifFalse: [pt := self makePointwithxValue: (self integerValueOf: rcvr) yValue: 0.
					"Above may cause GC!"
					self storePointer: 1 ofObject: pt withValue: (self stackValue: 0)]]
		ifFalse: [(self isFloatObject: rcvr)
				ifFalse: [^ self success: false].
			pt := self makePointwithxValue: 0 yValue: 0.
			"Above may cause GC!"
			self storePointer: 0 ofObject: pt withValue: (self stackValue: 1).
			self storePointer: 1 ofObject: pt withValue: (self stackValue: 0)].

	self pop: 2 thenPush: pt