debug printing
shortReversePrintFrameAndCallers: aFramePointer
	| theFP callerFP caller |
	<inline: false>
	<var: #aFramePointer type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	aFramePointer = 0 ifTrue:
		[^objectMemory nilObject].
	theFP := aFramePointer.
	[self shortPrintFrame: theFP.
	 callerFP := self frameCallerFP: theFP.
	 callerFP ~= 0] whileTrue:
		[theFP := callerFP].
	caller := self frameCallerContext: theFP.
	(objectMemory isForwarded: caller) ifTrue:
		[caller := objectMemory followForwarded: caller].
	^caller