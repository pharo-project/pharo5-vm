marshalling
ffiPushUnsignedInt: value in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	calloutState currentArg + 4 > calloutState limit ifTrue:
		[^FFIErrorCallFrameTooBig].
	interpreterProxy longAt: calloutState currentArg put: value.
	calloutState currentArg: calloutState currentArg + 4.
	^0