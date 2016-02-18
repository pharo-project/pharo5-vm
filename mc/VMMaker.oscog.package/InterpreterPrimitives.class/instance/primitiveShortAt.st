sound primitives
primitiveShortAt
	"Treat the receiver, which can be indexible by either bytes or words, as
	 an array of signed 16-bit values. Answer the contents of the given index.
	 Note that the index specifies the i-th 16-bit entry, not the i-th byte or word."

	| index rcvr value |
	index := self stackTop.
	(objectMemory isIntegerObject: index) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 1.
	(objectMemory isWordsOrBytes: rcvr) ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].
	index := objectMemory integerValueOf: index.
	((index >= 1) and: [index <= (objectMemory num16BitUnitsOf: rcvr)]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	value := objectMemory fetchShort16: index - 1 ofObject: rcvr.
	self cCode: []
		inSmalltalk: [value > 32767 ifTrue: [value := value - 65536]].
	self pop: 2 thenPushInteger: value