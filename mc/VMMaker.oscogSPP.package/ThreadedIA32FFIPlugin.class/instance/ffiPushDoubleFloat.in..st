marshalling
ffiPushDoubleFloat: value in: calloutState
	<var: #value type: #double>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	calloutState currentArg + 8 > calloutState limit ifTrue:
		[^FFIErrorCallFrameTooBig].
	interpreterProxy storeFloatAtPointer: calloutState currentArg from: value.
	calloutState currentArg: calloutState currentArg + 8.
	^0