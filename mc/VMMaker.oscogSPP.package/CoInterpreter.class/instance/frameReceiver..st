frame access
frameReceiver: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	^(self isMachineCodeFrame: theFP)
		ifTrue: [self mframeReceiver: theFP]
		ifFalse: [self iframeReceiver: theFP]