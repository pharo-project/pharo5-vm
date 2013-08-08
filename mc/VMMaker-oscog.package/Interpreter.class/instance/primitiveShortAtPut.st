sound primitives
primitiveShortAtPut
	"Treat the receiver, which can be indexible by either bytes or words, as an array of signed 16-bit values. Set the contents of the given index to the given value. Note that the index specifies the i-th 16-bit entry, not the i-th byte or word."

	| index rcvr sz addr value |
	value := self stackIntegerValue: 0.
	index := self stackIntegerValue: 1.
	rcvr := self stackValue: 2.
	self success: ((self isIntegerObject: rcvr) not and: [self isWordsOrBytes: rcvr]).
	successFlag ifFalse: [ ^ nil ].
	sz := ((self sizeBitsOf: rcvr) - BaseHeaderSize) // 2.  "number of 16-bit fields"
	self success: ((index >= 1) and: [index <= sz]).
	self success: ((value >= -32768) and: [value <= 32767]).
	successFlag ifTrue: [
		addr := rcvr + BaseHeaderSize + (2 * (index - 1)).
		self shortAt: addr put: value.
		self pop: 2.  "pop index and value; leave rcvr on stack"
	]