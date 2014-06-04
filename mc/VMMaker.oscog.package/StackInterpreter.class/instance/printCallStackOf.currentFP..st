debug printing
printCallStackOf: aContext currentFP: currFP
	| ctxt theFP thePage |
	<inline: false>
	<var: #currFP type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	ctxt := aContext.
	[ctxt = objectMemory nilObject] whileFalse:
		[(self isMarriedOrWidowedContext: ctxt)
			ifFalse:
				[self shortPrintContext: ctxt.
				 ctxt := objectMemory fetchPointer: SenderIndex ofObject: ctxt]
			ifTrue:
				[theFP := self frameOfMarriedContext: ctxt.
				 (self checkIsStillMarriedContext: ctxt currentFP: currFP)
					ifTrue:
						[thePage := stackPages stackPageFor: theFP.
						 (stackPages isFree: thePage) ifTrue:
							[self printHexPtr: theFP; print: ' is on a free page?!'; cr.
							 ^nil].
						 self shortPrintFrameAndCallers: theFP.
						 theFP := thePage baseFP.
						 ctxt := self frameCallerContext: theFP.
						 (objectMemory isForwarded: ctxt) ifTrue:
							[ctxt := objectMemory followForwarded: ctxt]]
					ifFalse: [self print: 'widowed caller frame '; printHexPtr: theFP; cr.
							^nil]]]