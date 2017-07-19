object access primitives
primitiveArrayBecomeOneWayNoCopyHash
	"Similar to primitiveArrayBecomeOneWay but does /not/ copy the receiver's
	 elements identity hashes over the argument's elements identity hashes."

	| arg rcvr ec |
	arg := self stackTop.
	rcvr := self stackValue: 1.
	ec := objectMemory become: rcvr with: arg twoWay: false copyHash: false.
	ec = PrimNoErr
		ifTrue: [self pop: 1]
		ifFalse: [self primitiveFailFor: ec]