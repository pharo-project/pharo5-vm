frame access
frameCallerSavedIP: theFP
	<inline: true>
	<returnTypeC: #'char *'>
	<var: #theFP type: #'char *'>
	^self pointerForOop: (stackPages longAt: theFP + FoxCallerSavedIP) "a.k.a. FoxCallerSavedIP"