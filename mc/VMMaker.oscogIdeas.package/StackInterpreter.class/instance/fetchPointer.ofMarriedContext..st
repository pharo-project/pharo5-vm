frame access
fetchPointer: offset ofMarriedContext: aContext
	"Fetch a slot from a married context.  Compute the value
	 of the relevant inst var from the spouse frame's state.

	 This method assumes frame pointers have been written back."
	| spouseFP |
	<inline: false>
	<var: #spouseFP type: #'char *'>

	self assert: (objectMemory isContext: aContext).
	self assert: (stackPage headFP = framePointer and: [stackPage headSP = stackPointer]).
	self assert: (self checkIsStillMarriedContext: aContext currentFP: framePointer).

	"method, closureOrNil & receiver need no special handling; only
	 sender, pc & stackp have to be computed for married contexts."
	offset <= ReceiverIndex ifTrue:
		[(self isReadMediatedContextInstVarIndex: offset) ifFalse:
			[^objectMemory fetchPointer: offset ofObject: aContext].

		 spouseFP := self frameOfMarriedContext: aContext.
		 offset = SenderIndex ifTrue:
			[^self ensureCallerContext: spouseFP].
		 offset = StackPointerIndex ifTrue:
			[^objectMemory integerObjectOf: (self stackPointerIndexForFrame: spouseFP)].
		 offset = InstructionPointerIndex ifTrue:
			[^self instructionPointerForFrame: spouseFP currentFP: framePointer currentIP: instructionPointer]].
	
	spouseFP := self frameOfMarriedContext: aContext.
	^(offset - ReceiverIndex between: 1 and: (self stackPointerIndexForFrame: spouseFP))
		ifTrue: [self temporary: offset - (ReceiverIndex + 1) in: spouseFP]
		ifFalse: [objectMemory nilObject]