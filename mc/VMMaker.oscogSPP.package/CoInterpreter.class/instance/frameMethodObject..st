frame access
frameMethodObject: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	^(self isMachineCodeFrame: theFP)
		ifTrue: [(self mframeHomeMethod: theFP) methodObject]
		ifFalse: [self iframeMethod: theFP]