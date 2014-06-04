frame access
iframeMethod: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	<returnTypeC: #usqInt>
	^stackPages longAt: theFP + FoxMethod