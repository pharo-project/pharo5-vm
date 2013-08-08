sound primitives
primitiveShortAt
	"Treat the receiver, which can be indexible by either bytes or words, as an array of signed 16-bit values. Return the contents of the given index. Note that the index specifies the i-th 16-bit entry, not the i-th byte or word."

	| index rcvr sz addr value |
	index := self stackIntegerValue: 0.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 1.
	((self isIntegerObject: rcvr)
	or: [(self isWordsOrBytes: rcvr) not]) ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	sz := ((self sizeBitsOf: rcvr) - BaseHeaderSize) // 2.  "number of 16-bit fields"
	((index >= 1) and: [index <= sz]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	addr := rcvr + BaseHeaderSize + (2 * (index - 1)).
	value := self shortAt: addr.
	self pop: 2 thenPushInteger: value