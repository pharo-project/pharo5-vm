primitive support
maybeOwnVM: calloutState threadIndex: myThreadIndex
	<var: #calloutState type: #'CalloutState *'>
	<inline: #always>
	self cppIf: COGMTVM ifTrue:
	[(calloutState callFlags anyMask: FFICallFlagThreaded) ifTrue:
		[interpreterProxy ownVM: myThreadIndex]]