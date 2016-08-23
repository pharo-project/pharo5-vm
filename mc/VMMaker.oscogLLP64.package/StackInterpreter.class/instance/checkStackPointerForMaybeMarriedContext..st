internal interpreter access
checkStackPointerForMaybeMarriedContext: aContext
	"Version of stackPointerForMaybeMarriedContext: with no side-effects (does not widow).
	 Used for assertion checking. Safe only in external primitives (framePointer valid).
	 Answer the stackPointer of a Context."
	| sp |
	<inline: true>
	(self checkIsStillMarriedContext: aContext currentFP: framePointer) ifTrue:
		[sp := self checkStackPointerIndexForFrame: (self frameOfMarriedContext: aContext).
		 self assert: ReceiverIndex + (objectMemory integerValueOf: sp) < (objectMemory lengthOf: aContext).
		 ^sp].
	(self isMarriedOrWidowedContext: aContext) ifTrue:
		[^self argumentCountOf: (objectMemory fetchPointer: MethodIndex ofObject: aContext)].
	^self fetchStackPointerOf: aContext