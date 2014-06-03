marshalling
ffiPushPointer: pointer in: calloutState
	<var: #pointer type: #'void *'>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	calloutState currentArg + 4 > calloutState limit ifTrue:
		[^FFIErrorCallFrameTooBig].
	interpreterProxy longAt: calloutState currentArg put: pointer.
	calloutState currentArg: calloutState currentArg + 4.
	^0