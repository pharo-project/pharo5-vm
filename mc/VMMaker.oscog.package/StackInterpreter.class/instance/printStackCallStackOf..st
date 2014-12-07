debug printing
printStackCallStackOf: frameOrContext
	<api>
	| theFP context |
	<var: #theFP type: #'char *'>
	(objectMemory addressCouldBeObj: frameOrContext) ifTrue:
		[((objectMemory isContext: frameOrContext)
		  and: [self checkIsStillMarriedContext: frameOrContext currentFP: nil]) ifTrue:
			[^self printStackCallStackOf: (self frameOfMarriedContext: frameOrContext) asInteger].
		 ^nil].
	 
	theFP := frameOrContext asVoidPointer.
	[context := self shortReversePrintFrameAndCallers: theFP.
	 ((self isMarriedOrWidowedContext: context)
	  and:
		[theFP := self frameOfMarriedContext: context.
		 self checkIsStillMarriedContext: context currentFP: theFP]) ifFalse:
			[^nil]] repeat