debug printing
printContextCallStackOf: aContext
	"Print the call stack of aContext until it links to a frame."
	| ctxt |
	<inline: false>
	ctxt := aContext.
	[ctxt = objectMemory nilObject or: [self isMarriedOrWidowedContext: ctxt]] whileFalse:
		[self shortPrintContext: ctxt.
		 ctxt := objectMemory fetchPointer: SenderIndex ofObject: ctxt].
	^ctxt