debug printing
printContextCallStackOf: aContext
	"Print the call stack of aContext until it links to a frame."
	| ctxt |
	<inline: false>
	ctxt := aContext.
	[ctxt = nilObj] whileFalse:
		[self shortPrintContext: ctxt.
		 ctxt := self fetchPointer: SenderIndex ofObject: ctxt].
	^ctxt