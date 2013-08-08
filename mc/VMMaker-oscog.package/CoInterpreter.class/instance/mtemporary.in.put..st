internal interpreter access
mtemporary: offset in: theFP put: valueOop
	"Temporary access for a machine code frame only."
	"See StackInterpreter class>>initializeFrameIndices"
	| frameNumArgs |
	<inline: true>
	<var: #theFP type: #'char *'>
	^stackPages
		longAt: (offset < (frameNumArgs := self mframeNumArgs: theFP)
					ifTrue: [theFP + FoxCallerSavedIP + ((frameNumArgs - offset) * BytesPerWord)]
					ifFalse: [theFP + FoxMFReceiver - BytesPerWord + ((frameNumArgs - offset) * BytesPerWord)])
		put: valueOop