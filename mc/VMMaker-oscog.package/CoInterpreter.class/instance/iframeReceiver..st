frame access
iframeReceiver: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	^stackPages longAt: theFP + FoxIFReceiver