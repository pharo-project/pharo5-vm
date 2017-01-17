sound primitives
primitiveIntegerAt
	"Return the 32bit signed integer contents of a words receiver"

	| index rcvr sz addr intValue result |
	<var: #intValue type: #int>
	index := self stackValue: 0.
	(objectMemory isIntegerObject: index) ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 1.
	(objectMemory isWords: rcvr) ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].
	index := objectMemory integerValueOf: index.
	sz := objectMemory lengthOf: rcvr.  "number of fields"
	(index >= 1 and: [index <= sz]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	"4 = 32 bits / 8"
	addr := rcvr + objectMemory baseHeaderSize + (index - 1 * 4). "for zero indexing"
	intValue := objectMemory intAt: addr.
	result := self signed32BitIntegerFor: intValue.
	self pop: 2 thenPush: result