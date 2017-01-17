frame access
setFrameHasNotNativeFrame: theFP
	<inline: true>
	<option: #LowcodeVM>
	<var: #theFP type: #'char *'>
	self temporary: (self frameNumArgs: theFP) in: theFP put: (objectMemory nilObject)