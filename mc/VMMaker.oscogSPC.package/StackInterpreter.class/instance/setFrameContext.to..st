frame access
setFrameContext: theFP to: aContext
	<inline: true>
	<var: #theFP type: #'char *'>
	stackPages longAt: theFP + FoxThisContext put: aContext