object access primitives
primitiveArrayBecomeForceImmutables
	"We must flush the method cache here, to eliminate stale references
	to mutated classes and/or selectors.  This version succeeds for immutables."

	| arg rcvr ec |
	arg := self stackTop.
	rcvr := self stackValue: 1.
	ec := self become: rcvr with: arg twoWay: true copyHash: true forceImmutables: true.
	ec = PrimNoErr
		ifTrue: [self pop: 1]
		ifFalse: [self primitiveFailFor: ec]