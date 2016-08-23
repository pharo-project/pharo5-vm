frame access
iframeIsBlockActivation: theFP
	self assert: (self isMachineCodeFrame: theFP) not.
	^super iframeIsBlockActivation: theFP