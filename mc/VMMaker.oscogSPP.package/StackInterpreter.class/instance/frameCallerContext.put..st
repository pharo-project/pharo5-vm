frame access
frameCallerContext: theFP put: aValue
	<inline: true>
	<var: #theFP type: #'char *'>
	^stackPages
		longAt: theFP + FoxCallerContext "a.k.a. FoxCallerSavedIP"
		put: aValue