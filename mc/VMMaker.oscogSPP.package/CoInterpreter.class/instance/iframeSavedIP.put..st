frame access
iframeSavedIP: theFP put: savedIP
	<var: #theFP type: #'char *'>
	self assert: (self isMachineCodeFrame: theFP) not.
	stackPages longAt: theFP + FoxIFSavedIP put: savedIP