marshalling
ffiPushUnsignedLongLong: value in: calloutState
	<var: #value type: #usqLong>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	calloutState currentArg + 8 > calloutState limit ifTrue:
		[^FFIErrorCallFrameTooBig].
	interpreterProxy
		longAt: calloutState currentArg put: (self cCoerceSimple: value to: #usqInt);
		longAt: calloutState currentArg + 4 put: (self cCoerceSimple: value >> 32 to: #usqInt).
	calloutState currentArg: calloutState currentArg + 8.
	^0