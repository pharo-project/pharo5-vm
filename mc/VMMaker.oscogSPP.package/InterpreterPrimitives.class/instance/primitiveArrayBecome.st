object access primitives
primitiveArrayBecome
	"We must flush the method cache here, to eliminate stale references
	to mutated classes and/or selectors."

	| arg rcvr ec |
	arg := self stackTop.
	rcvr := self stackValue: 1.
	ec := objectMemory become: rcvr with: arg twoWay: true copyHash: false.
	ec = PrimNoErr
		ifTrue: [self pop: 1]
		ifFalse: [self primitiveFailFor: ec]