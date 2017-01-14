marshalling
ffiPushSingleFloat: value in: calloutState
	<var: #value type: #float>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	calloutState currentArg + 4 > calloutState limit ifTrue:
		[^FFIErrorCallFrameTooBig].
	interpreterProxy storeSingleFloatAtPointer: calloutState currentArg from: value.
	calloutState currentArg: calloutState currentArg + 4.
	^0