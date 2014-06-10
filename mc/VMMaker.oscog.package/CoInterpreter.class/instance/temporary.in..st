internal interpreter access
temporary: offset in: theFP
	"See StackInterpreter class>>initializeFrameIndices"
	| frameNumArgs |
	<inline: true>
	<var: #theFP type: #'char *'>
	^(self isMachineCodeFrame: theFP)
		ifTrue:
			[offset < (frameNumArgs := self mframeNumArgs: theFP)
				ifTrue: [stackPages longAt: theFP + FoxCallerSavedIP + ((frameNumArgs - offset) * BytesPerWord)]
				ifFalse: [stackPages longAt: theFP + FoxMFReceiver - BytesPerWord + ((frameNumArgs - offset) * BytesPerWord)]]
		ifFalse:
			[self itemporary: offset in: theFP]