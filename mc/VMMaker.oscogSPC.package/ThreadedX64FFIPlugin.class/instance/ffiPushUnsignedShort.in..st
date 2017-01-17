marshalling
ffiPushUnsignedShort: value in: calloutState
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	calloutState integerRegisterIndex < NumIntRegArgs
		ifTrue:
			[calloutState integerRegisters at: calloutState integerRegisterIndex put: (self cCoerceSimple: value to: #'unsigned short').
			 calloutState incrementIntegerRegisterIndex]
		ifFalse:
			[calloutState currentArg + WordSize > calloutState limit ifTrue:
				[^FFIErrorCallFrameTooBig].
			 interpreterProxy longAt: calloutState currentArg put: (self cCoerceSimple: value to: #'unsigned short').
			 calloutState currentArg: calloutState currentArg + WordSize].
	^0