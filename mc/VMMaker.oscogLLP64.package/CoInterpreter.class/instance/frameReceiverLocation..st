frame access
frameReceiverLocation: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	^(self isMachineCodeFrame: theFP)
		ifTrue: [theFP + FoxMFReceiver]
		ifFalse: [theFP + FoxIFReceiver]