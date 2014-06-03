object access primitives
primitiveIdentical
	"is the receiver/first argument the same object as the (last) argument?.
	 pop argumentCount because this can be used as a mirror primitive."
	| thisObject otherObject |
	otherObject := self stackValue: 1.
	thisObject := self stackTop.
	(objectMemory isOopForwarded: otherObject) ifTrue:
		[self assert: argumentCount > 1.
		 otherObject := objectMemory followForwarded: thisObject].
	self assert: (objectMemory isOopForwarded: otherObject) not.
	(objectMemory isOopForwarded: thisObject) ifTrue:
		[thisObject := objectMemory followForwarded: thisObject].
	self pop: argumentCount + 1 thenPushBool: thisObject = otherObject