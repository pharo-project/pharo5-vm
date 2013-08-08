internal interpreter access
fetchStackPointerOf: aContext
	"Return the stackPointer of a Context or BlockContext.
	 Does not deal with married contexts.  Use only for debug
	 printing or object tracing functions.  To obtain an accurate
	 stack pointer use stackPointerForMaybeMarriedContext:"
	| sp |
	<inline: true>
	sp := objectMemory fetchPointer: StackPointerIndex ofObject: aContext.
	(objectMemory isIntegerObject: sp) ifFalse: [^0].
	self assert: ReceiverIndex + (objectMemory integerValueOf: sp) < (objectMemory lengthOf: aContext).
	^objectMemory integerValueOf: sp