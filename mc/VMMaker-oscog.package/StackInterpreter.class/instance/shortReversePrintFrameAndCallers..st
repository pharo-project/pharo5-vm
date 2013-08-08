debug printing
shortReversePrintFrameAndCallers: aFramePointer
	| theFP callerFP |
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
	^self frameCallerContext: theFP