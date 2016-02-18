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
	(objectMemory isWords: rcvr) ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].
	(objectMemory isObjImmutable: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].
	sz := objectMemory lengthOf: rcvr.  "number of fields"
	(index >= 1 and: [index <= sz]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	"4 = 32 bits / 8"
	addr := rcvr + objectMemory baseHeaderSize + (index - 1 * 4). "for zero indexing"
	value := objectMemory intAt: addr put: value.
	self pop: 3 thenPush: valueOop "pop all; return value"
