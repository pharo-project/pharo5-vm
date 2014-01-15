debug printing
printCallStackOf: aContextOrProcess
	<api>
	| context |
	<inline: false>
	<var: #theFP type: #'char *'>
	((objectMemory isContext: aContextOrProcess) not
	and: [(objectMemory lengthOf: aContextOrProcess) > MyListIndex
	and: [objectMemory isContext: (objectMemory
									fetchPointer: SuspendedContextIndex
									ofObject: aContextOrProcess)]]) ifTrue:
		[^self printCallStackOf: (objectMemory
									fetchPointer: SuspendedContextIndex
									ofObject: aContextOrProcess)].
	context := aContextOrProcess.
	[context = objectMemory nilObject] whileFalse:
		[(self isMarriedOrWidowedContext: context)
			ifTrue:
				[(self checkIsStillMarriedContext: context currentFP: framePointer) ifFalse:
					[self shortPrintContext: context.
					 ^nil].
				 context := self shortReversePrintFrameAndCallers: (self frameOfMarriedContext: context)]
			ifFalse:
				[context := self printContextCallStackOf: context]]