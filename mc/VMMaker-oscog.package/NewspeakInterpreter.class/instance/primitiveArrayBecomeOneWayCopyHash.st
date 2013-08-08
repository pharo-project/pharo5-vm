object access primitives
primitiveArrayBecomeOneWayCopyHash
	"Similar to primitiveArrayBecomeOneWay but accepts a third
	 argument whether to copy the receiver's identity hash over
	 the argument's identity hash.  This version fails for immutables."

	| copyHash arg rcvr ec |
	copyHash := self booleanValueOf: (self stackTop).
	arg := self stackValue: 1.
	rcvr := self stackValue: 2.
	ec := self become: rcvr with: arg twoWay: false copyHash: copyHash forceImmutables: false.
	ec = PrimNoErr
		ifTrue: [self pop: 2]
		ifFalse: [self primitiveFailFor: ec]