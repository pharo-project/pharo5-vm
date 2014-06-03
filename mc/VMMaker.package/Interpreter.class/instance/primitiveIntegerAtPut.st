sound primitives
primitiveIntegerAtPut
	"Return the 32bit signed integer contents of a words receiver"
	| index rcvr sz addr value valueOop |
	valueOop := self stackValue: 0.
	index := self stackIntegerValue: 1.
	rcvr := self stackValue: 2.
	(self isIntegerObject: rcvr) ifTrue:[^self success: false].
	(self isWords: rcvr) ifFalse:[^self success: false].
	sz := self lengthOf: rcvr.  "number of fields"
	((index >= 1) and: [index <= sz]) ifFalse:[^self success: false].
	value := self signed32BitValueOf: valueOop.
	successFlag ifTrue:[
		addr := rcvr + BaseHeaderSize + (index - 1 * BytesPerWord). "for zero indexing"
		value := self intAt: addr put: value.
		self pop: 3 thenPush: valueOop. "pop all; return value"
	].
