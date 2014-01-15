sound primitives
primitiveIntegerAtPut
	"Return the 32bit signed integer contents of a words receiver"
	| index rcvr sz addr value valueOop |
	<var: 'value' type: 'int'>
	valueOop := self stackValue: 0.
	index := self stackIntegerValue: 1.
	value := self signed32BitValueOf: valueOop.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 2.
	((objectMemory isIntegerObject: rcvr)
	or: [(objectMemory isWords: rcvr) not]) ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	sz := objectMemory lengthOf: rcvr.  "number of fields"
	(index >= 1 and: [index <= sz]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	addr := rcvr + BaseHeaderSize + (index - 1 * BytesPerWord). "for zero indexing"
	value := self intAt: addr put: value.
	self pop: 3 thenPush: valueOop "pop all; return value"
