object access primitives
primitiveClone
	"Return a shallow copy of the receiver."

	| rcvr newCopy |
	rcvr := self stackTop.
	(objectMemory isImmediate: rcvr)
		ifTrue:
			[newCopy := rcvr]
		ifFalse:
			[(argumentCount = 0
			  or: [(objectMemory isForwarded: rcvr) not])
				ifTrue: [newCopy := objectMemory clone: rcvr]
				ifFalse: [newCopy := 0].
			 newCopy = 0 ifTrue: "not enough memory most likely"
				[^self primitiveFail]].
	self pop: argumentCount + 1 thenPush: newCopy