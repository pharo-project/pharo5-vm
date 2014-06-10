object access primitives
primitiveClone
	"Return a shallow copy of the receiver."

	| rcvr newCopy |
	rcvr := self stackTop.
	(objectMemory isImmediate: rcvr)
		ifTrue:
			[newCopy := rcvr]
		ifFalse:
			[newCopy := objectMemory clone: rcvr.
			 newCopy = 0 ifTrue: "not enough memory most likely"
				[^self primitiveFail]].
	self pop: argumentCount + 1 thenPush: newCopy