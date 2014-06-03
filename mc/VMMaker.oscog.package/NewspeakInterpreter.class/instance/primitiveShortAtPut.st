sound primitives
primitiveShortAtPut
	"Treat the receiver, which can be indexible by either bytes or words, as an array of signed 16-bit values. Set the contents of the given index to the given value. Note that the index specifies the i-th 16-bit entry, not the i-th byte or word."

	| index rcvr sz addr value |
	value := self stackIntegerValue: 0.
	index := self stackIntegerValue: 1.
	(self successful and: [(value >= -32768) and: [value <= 32767]]) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 2.
	((self isIntegerObject: rcvr) not and: [self isWordsOrBytes: rcvr]) ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].
	sz := ((self sizeBitsOf: rcvr) - BaseHeaderSize) // 2.  "number of 16-bit fields"
	(index >= 1 and: [index <= sz]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	(self isOopImmutable: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].
	addr := rcvr + BaseHeaderSize + (2 * (index - 1)).
	self shortAt: addr put: value.
	self pop: 3 thenPush: (self integerObjectOf: value) "pop all; return value"