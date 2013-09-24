debug printing
printStackCallStack
	<doNotGenerate>
	| theFP context |
	theFP := localFP.
	[context := self shortReversePrintFrameAndCallers: theFP.
	 ((self isMarriedOrWidowedContext: context)
	  and: [self checkIsStillMarriedContext: context currentFP: localFP]) ifFalse:
		[^nil].
	 theFP := self frameOfMarriedContext: context] repeat