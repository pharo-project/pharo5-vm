frame access
iframeSavedIP: theFP
	self assert: (self isMachineCodeFrame: theFP) not.
	^super iframeSavedIP: theFP