frame access
frameContext: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	^stackPages longAt: theFP + FoxThisContext