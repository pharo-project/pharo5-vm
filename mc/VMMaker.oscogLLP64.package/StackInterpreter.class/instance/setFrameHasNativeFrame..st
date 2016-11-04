frame access
setFrameHasNativeFrame: theFP
	<inline: true>
	<var: #theFP type: #'char *'>
	self temporary: (self frameNumArgs: theFP) in: theFP put: (objectMemory splObj: LowcodeContextMark)