sound primitives
primitiveIntegerAt
	"Return the 32bit signed integer contents of a words receiver"

	| index rcvr sz addr value |
	index := self stackIntegerValue: 0.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 1.
	((self isIntegerObject: rcvr)
	or: [(self isWords: rcvr) not]) ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	sz := self lengthOf: rcvr.  "number of fields"
	((index >= 1) and: [index <= sz]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	addr := rcvr + BaseHeaderSize - 4 "for zero indexing" + (index * 4).
	value := self intAt: addr.
	self pop: 2.  "pop rcvr, index"
	"push element value"
	(self isIntegerValue: value)
		ifTrue: [self pushInteger: value]
		ifFalse: [self push: (self signed32BitIntegerFor: value)]