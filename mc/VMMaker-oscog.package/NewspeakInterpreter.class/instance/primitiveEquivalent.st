object access primitives
primitiveEquivalent
"is the receiver the same object as the argument?"
	| thisObject otherObject |
	otherObject := self popStack.
	thisObject := self popStack.
	self pushBool: thisObject = otherObject