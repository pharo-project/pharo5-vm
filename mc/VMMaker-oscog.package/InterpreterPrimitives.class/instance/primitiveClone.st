object access primitives
primitiveClone
	"Return a shallow copy of the receiver."

	| newCopy |
	newCopy := objectMemory clone: (self stackTop).
	newCopy = 0
		ifTrue:["not enough memory most likely" ^self primitiveFail].
	self pop: 1 thenPush: newCopy.