frame access
frameOfMarriedContext: aContext 
	| senderOop |
	<inline: true>
	<returnTypeC: 'char *'>
	senderOop := objectMemory fetchPointer: SenderIndex ofObject: aContext.
	^self withoutSmallIntegerTags: senderOop