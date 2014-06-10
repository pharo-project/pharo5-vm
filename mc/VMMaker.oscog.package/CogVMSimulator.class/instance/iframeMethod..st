frame access
iframeMethod: theFP
	self assert: (self isMachineCodeFrame: theFP) not.
	^super iframeMethod: theFP