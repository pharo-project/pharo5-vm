object access primitives
primitiveClone
	"Return a shallow copy of the receiver.
	 Special-case non-single contexts (because of context-to-stack mapping).
	 Can't fail for contexts cuz of image context instantiation code (sigh)."

	| rcvr newCopy |
	rcvr := self stackTop.
	(objectMemory isImmediate: rcvr)
		ifTrue:
			[newCopy := rcvr]
		ifFalse:
			[(objectMemory isContextNonImm: rcvr)
				ifTrue:
					[newCopy := self cloneContext: rcvr]
				ifFalse:
					[newCopy := objectMemory clone: rcvr].
			newCopy = 0 ifTrue:
				[^self primitiveFailFor: PrimErrNoMemory]].
	self pop: argumentCount + 1 thenPush: newCopy