frame access
frameMethodObject: theFP
	"Homonym of frameMethod: for compatibility with CoInterpreter"
	<inline: true>
	<var: #theFP type: #'char *'>
	^stackPages longAt: theFP + FoxMethod