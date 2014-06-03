frame access
frameOfMarriedContext: aContext 
	| value |
	<inline: true>
	<returnTypeC: 'char *'>
	value := objectMemory fetchPointer: SenderIndex ofObject: aContext.
	^self withoutSmallIntegerTags: value