sound primitives
primitiveIntegerAt
	"Return the 32bit signed integer contents of a words receiver"

	| index rcvr sz addr value intValue |
	<var: #intValue type: 'int'>
	index := self stackIntegerValue: 0.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 1.
	((objectMemory isIntegerObject: rcvr)
	or: [(objectMemory isWords: rcvr) not]) ifTrue:
		[^self primitiveFailFor: PrimErrInappropriate].
	sz := objectMemory lengthOf: rcvr.  "number of fields"
	((index >= 1) and: [index <= sz]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	addr := rcvr + BaseHeaderSize + (index - 1 * BytesPerWord). "for zero indexing"
	value := self intAt: addr.
	self pop: 2.  "pop rcvr, index"
	"push element value"
	(objectMemory isIntegerValue: value)
		ifTrue: [self pushInteger: value]
		ifFalse: [intValue := value. "32 bit int may have been stored in 32 or 64 bit sqInt"
				self push: (self signed32BitIntegerFor: intValue)] "intValue may be sign extended to 64 bit sqInt"