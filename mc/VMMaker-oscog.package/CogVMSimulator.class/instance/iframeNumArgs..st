frame access
iframeNumArgs: theFP
	self assert: (self isMachineCodeFrame: theFP) not.
	^super iframeNumArgs: theFP