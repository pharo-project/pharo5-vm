internal interpreter access
stackPointerForMaybeMarriedContext: aContext
	"Return the stackPointer of a Context or BlockContext."
	| sp |
	<inline: true>
	(self isStillMarriedContext: aContext) ifTrue:
		[sp := self stackPointerIndexForFrame: (self frameOfMarriedContext: aContext).
		 self assert: ReceiverIndex + (objectMemory integerValueOf: sp) < (objectMemory lengthOf: aContext).
		 ^sp].
	^self fetchStackPointerOf: aContext