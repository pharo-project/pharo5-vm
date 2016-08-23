frame access
frameNumTemps: theFP
	"For subclasses to redefine to implement different closure semantics."
	<var: #theFP type: #'char *'>
	^0