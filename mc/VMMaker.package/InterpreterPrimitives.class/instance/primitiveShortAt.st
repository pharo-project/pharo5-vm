sound primitives
primitiveShortAt
	"Treat the receiver, which can be indexible by either bytes or words, as an array of signed 16-bit values. Return the contents of the given index. Note that the index specifies the i-th 16-bit entry, not the i-th byte or word."

	| index rcvr sz addr value |
	index := self stackIntegerValue: 0.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 1.
	(objectMemory isWordsOrBytes: rcvr) ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].
	sz := (objectMemory numSlotsOf: rcvr) * objectMemory bytesPerOop // 2.  "number of 16-bit fields"
	((index >= 1) and: [index <= sz]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	addr := rcvr + objectMemory baseHeaderSize + (2 * (index - 1)).
	value := objectMemory shortAt: addr.
	self pop: 2 thenPushInteger: value