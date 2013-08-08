frame access
frameHasContext: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	^(self isMachineCodeFrame: theFP)
		ifTrue: [self mframeHasContext: theFP]
		ifFalse: [self iframeHasContext: theFP]