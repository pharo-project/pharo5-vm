object access primitives
primitiveClone
	"Return a shallow copy of the receiver."

	| newCopy |
	newCopy := self clone: self stackTop.
	newCopy = 0 ifTrue: "not enough memory most likely"
		[^self primitiveFail].
	self pop: argumentCount + 1 thenPush: newCopy