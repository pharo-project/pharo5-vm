sound primitives
primitiveIntegerAt
	"Return the 32bit signed integer contents of a words receiver"

	| index rcvr sz addr value intValue |
	<var: #intValue type: 'int'>
	index := self stackIntegerValue: 0.
	self successful ifFalse:
		[^self primitiveFailFor: PrimErrBadArgument].
	rcvr := self stackValue: 1.
	(objectMemory isWords: rcvr) ifFalse:
		[^self primitiveFailFor: PrimErrInappropriate].
	sz := objectMemory lengthOf: rcvr.  "number of fields"
	((index >= 1) and: [index <= sz]) ifFalse:
		[^self primitiveFailFor: PrimErrBadIndex].
	"4 = 32 bits / 8"
	addr := rcvr + objectMemory baseHeaderSize + (index - 1 * 4). "for zero indexing"
	value := objectMemory intAt: addr.
	self pop: 2.  "pop rcvr, index"
	"push element value"
	(objectMemory isIntegerValue: value)
		ifTrue: [self pushInteger: value]
		ifFalse: [intValue := value. "32 bit int may have been stored in 32 or 64 bit sqInt"
				self push: (self signed32BitIntegerFor: intValue)] "intValue may be sign extended to 64 bit sqInt"