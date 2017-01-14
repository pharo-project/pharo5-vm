marshalling
ffiPushSignedShort: value in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	calloutState integerRegisterIndex < NumIntRegArgs
		ifTrue:
			[calloutState integerRegisters at: calloutState integerRegisterIndex put: (self cCoerceSimple: value to: #'signed short').
			 calloutState integerRegisterIndex: calloutState integerRegisterIndex + 1]
		ifFalse:
			[calloutState currentArg + 4 > calloutState limit ifTrue:
				[^FFIErrorCallFrameTooBig].
			 interpreterProxy longAt: calloutState currentArg put: (self cCoerceSimple: value to: #'signed short').
			 calloutState currentArg: calloutState currentArg + 4].
	^0