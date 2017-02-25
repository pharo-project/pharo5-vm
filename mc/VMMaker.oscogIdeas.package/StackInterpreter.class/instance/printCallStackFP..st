debug printing
printCallStackFP: theFP
	| context |
	<inline: false>
	<var: #theFP type: #'char *'>
	context := self shortReversePrintFrameAndCallers: theFP.
	[context = objectMemory nilObject] whileFalse:
		[(self isMarriedOrWidowedContext: context)
			ifTrue:
				[(self checkIsStillMarriedContext: context currentFP: framePointer) ifFalse:
					[self shortPrintContext: context.
					 ^nil].
				 context := self shortReversePrintFrameAndCallers: (self frameOfMarriedContext: context)]
			ifFalse:
				[context := self printContextCallStackOf: context]]