internal interpreter access
itemporary: offset in: theFP
	"Temporary access for an interpreter frame only."
	"See StackInterpreter class>>initializeFrameIndices"
	| frameNumArgs |
	<inline: true>
	<var: #theFP type: #'char *'>
	^offset < (frameNumArgs := self iframeNumArgs: theFP)
		ifTrue: [stackPages longAt: theFP + FoxCallerSavedIP + ((frameNumArgs - offset) * BytesPerWord)]
		ifFalse: [stackPages longAt: theFP + FoxIFReceiver - BytesPerWord + ((frameNumArgs - offset) * BytesPerWord)]