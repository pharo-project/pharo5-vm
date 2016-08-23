object access primitives
primitiveIdentical
	"is the receiver/first argument the same object as the (last) argument?.
	 pop argumentCount because this can be used as a mirror primitive."
	| thisObject otherObject |
	otherObject := self stackValue: 1.
	thisObject := self stackTop.
	((objectMemory isOopForwarded: otherObject)
	 or: [argumentCount > 1
		 and: [objectMemory isOopForwarded: thisObject]])
		ifTrue:
			[self primitiveFailFor: PrimErrBadArgument]
		ifFalse:
			[self pop: argumentCount + 1 thenPushBool: thisObject = otherObject]