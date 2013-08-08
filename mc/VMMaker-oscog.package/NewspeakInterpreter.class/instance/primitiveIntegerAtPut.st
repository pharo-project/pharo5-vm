sound primitives
primitiveIntegerAtPut
	"Return the 32bit signed integer contents of a words receiver"
	| index rcvr sz addr value valueOop |
	valueOop := self stackValue: 0.
	index := self stackIntegerValue: 1.
	(self isIntegerObject: valueOop)
		ifTrue:[value := self integerValueOf: valueOop]
		ifFalse:[value := self signed32BitValueOf: valueOop].
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 2.
	((self isIntegerObject: rcvr)
	or: [(self isWords: rcvr) not]) ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	sz := self lengthOf: rcvr.  "number of fields"
	(index >= 1 and: [index <= sz]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	(self isOopImmutable: rcvr) ifTrue:
		[^self primitiveFailFor: PrimErrNoModification].
	addr := rcvr + BaseHeaderSize - 4 "for zero indexing" + (index * 4).
	value := self intAt: addr put: value.
	self pop: 3 thenPush: valueOop "pop all; return value"
