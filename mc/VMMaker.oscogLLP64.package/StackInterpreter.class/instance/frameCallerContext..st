frame access
frameCallerContext: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	^stackPages longAt: theFP + FoxCallerContext "a.k.a. FoxCallerSavedIP"