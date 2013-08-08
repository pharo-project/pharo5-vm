frame access
frameIsBlockActivation: theFP "<Integer>"
	<inline: true>
	<var: #theFP type: #'char *'>
	^(self isMachineCodeFrame: theFP)
		ifTrue: [self mframeIsBlockActivation: theFP]
		ifFalse: [self iframeIsBlockActivation: theFP]