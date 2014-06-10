frame access
iframeSavedIP: theFP
	<var: #theFP type: #'char *'>
	^stackPages longAt: theFP + FoxIFSavedIP