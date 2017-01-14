sound primitives
primitiveShortAtPut
	"Treat the receiver, which can be indexible by either bytes or words, as an array
	 of signed 16-bit values. Set the contents of the given index to the given value.
	 Note that the index specifies the i-th 16-bit entry, not the i-th byte or word."

	| index rcvr value |
	value := self stackTop.
	index := self stackValue: 1.
	((objectMemory isIntegerObject: value)
	 and: [(objectMemory isIntegerObject: index)
	 and: [value := objectMemory integerValueOf: value.
		  (value >= -32768) and: [value <= 32767]]]) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 2.
	(objectMemory isWordsOrBytes: rcvr) ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].
	(objectMemory isObjImmutable: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].
	index := objectMemory integerValueOf: index.
	(index >= 1 and: [index <= (objectMemory num16BitUnitsOf: rcvr)]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	objectMemory storeShort16: index - 1 ofObject: rcvr withValue: value.
	self pop: 3 thenPush: (objectMemory integerObjectOf: value)