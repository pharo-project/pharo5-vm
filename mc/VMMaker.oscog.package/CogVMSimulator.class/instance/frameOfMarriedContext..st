frame access
frameOfMarriedContext: aContext 
	| senderOop |
	senderOop := objectMemory fetchPointer: SenderIndex ofObject: aContext.
	self assert: (objectMemory isIntegerObject: senderOop).
	^self withoutSmallIntegerTags: senderOop