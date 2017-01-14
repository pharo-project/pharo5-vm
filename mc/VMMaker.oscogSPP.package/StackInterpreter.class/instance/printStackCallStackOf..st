debug printing
printStackCallStackOf: aContextOrProcessOrFrame
	<api>
	| theFP context |
	<var: #theFP type: #'char *'>
	(self cCode: [false] "In the stack simulator, frame pointers are negative which upsets addressCouldBeObj:"
		inSmalltalk: [stackPages couldBeFramePointer: aContextOrProcessOrFrame]) ifFalse:
		[(objectMemory addressCouldBeObj: aContextOrProcessOrFrame) ifTrue:
			[((objectMemory isContext: aContextOrProcessOrFrame)
			  and: [self checkIsStillMarriedContext: aContextOrProcessOrFrame currentFP: nil]) ifTrue:
				[^self printStackCallStackOf: (self frameOfMarriedContext: aContextOrProcessOrFrame) asInteger].
			 (self couldBeProcess: aContextOrProcessOrFrame) ifTrue:
				[^self printCallStackOf: (objectMemory
											fetchPointer: SuspendedContextIndex
											ofObject: aContextOrProcessOrFrame)].
			 ^nil]].

	theFP := aContextOrProcessOrFrame asVoidPointer.
	[context := self shortReversePrintFrameAndCallers: theFP.
	 ((self isMarriedOrWidowedContext: context)
	  and:
		[theFP := self frameOfMarriedContext: context.
		 self checkIsStillMarriedContext: context currentFP: theFP]) ifFalse:
			[^nil]] repeat