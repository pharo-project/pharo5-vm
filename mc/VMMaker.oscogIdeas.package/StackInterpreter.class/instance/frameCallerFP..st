frame access
frameCallerFP: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	<returnTypeC: 'char *'>
	^self pointerForOop: (stackPages longAt: theFP + FoxSavedFP)