internal interpreter access
numSlotsOfMarriedContext: aContext
	"Answer the number of effective pointer fields in the given context."
	<inline: true>
	| contextSize |
	contextSize := self stackPointerIndexForFrame: (self frameOfMarriedContext: aContext).
	^CtxtTempFrameStart + contextSize