debug printing
printStackCallStackOf: aFramePointer
	<var: #aFramePointer type: #'char *'>
	<api>
	| theFP context |
	<var: #theFP type: #'char *'>
	theFP := aFramePointer.
	[context := self shortReversePrintFrameAndCallers: theFP.
	 ((self isMarriedOrWidowedContext: context)
	  and:
		[theFP := self frameOfMarriedContext: context.
		 self checkIsStillMarriedContext: context currentFP: theFP]) ifFalse:
			[^nil]] repeat