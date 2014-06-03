object access primitives
primitiveArrayBecomeOneWayCopyHash
	"Similar to primitiveArrayBecomeOneWay but accepts a third argument whether to copy
	the receiver's identity hash over the argument's identity hash."

	| copyHashFlag arg rcvr |
	copyHashFlag := self booleanValueOf: (self stackTop).
	arg := self stackValue: 1.
	rcvr := self stackValue: 2.
	self success: (self become: rcvr with: arg twoWay: false copyHash: copyHashFlag).
	successFlag ifTrue: [ self pop: 2 ].