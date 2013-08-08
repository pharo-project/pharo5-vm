internal interpreter access
nacFetchStackPointerOf: aContext
	"A version of fetchStackPointerOf: for use when objects may be forwarded.
	 Does not do an assert-check of the stack pointer being in bounds."
	| sp |
	<inline: true>
	sp := objectMemory fetchPointer: StackPointerIndex ofObject: aContext.
	(objectMemory isIntegerObject: sp) ifFalse: [^0].
	^objectMemory integerValueOf: sp