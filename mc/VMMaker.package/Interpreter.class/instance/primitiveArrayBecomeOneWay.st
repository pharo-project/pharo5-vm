object access primitives
primitiveArrayBecomeOneWay
	"We must flush the method cache here, to eliminate stale references
	to mutated classes and/or selectors."

	| arg rcvr |
	arg := self stackTop.
	rcvr := self stackValue: 1.
	self success: (self become: rcvr with: arg twoWay: false copyHash: true).
	successFlag ifTrue: [ self pop: 1 ].