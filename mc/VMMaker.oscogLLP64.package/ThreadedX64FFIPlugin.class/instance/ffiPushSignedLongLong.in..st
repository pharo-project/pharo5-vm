marshalling
ffiPushSignedLongLong: value in: calloutState
	<var: #value type: #sqLong>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	calloutState integerRegisterIndex < NumIntRegArgs
		ifTrue:
			[calloutState integerRegisters at: calloutState integerRegisterIndex put: (self cCoerceSimple: value to: #usqInt).
			 calloutState incrementIntegerRegisterIndex]
		ifFalse:
			[calloutState currentArg + WordSize > calloutState limit ifTrue: [^FFIErrorCallFrameTooBig].
			 interpreterProxy longAt: calloutState currentArg put: value.
			 calloutState currentArg: calloutState currentArg + WordSize].
	^0