object access primitives
primitiveArrayBecomeOneWayCopyHash
	"Similar to primitiveArrayBecomeOneWay but accepts a third argument deciding whether to
	 copy the receiver's element's identity hash over the argument's elementy's identity hash."

	| copyHashFlag ec |
	self stackTop = objectMemory trueObject
		ifTrue: [copyHashFlag := true]
		ifFalse:
			[self stackTop = objectMemory falseObject
				ifTrue: [copyHashFlag := false]
				ifFalse:
					[self primitiveFailFor: PrimErrBadArgument.
					 ^nil]].
	ec := objectMemory
			become: (self stackValue: 2)
			with: (self stackValue: 1)
			twoWay: false
			copyHash: copyHashFlag.
	ec = PrimNoErr
		ifTrue: [self pop: argumentCount]
		ifFalse: [self primitiveFailFor: ec]