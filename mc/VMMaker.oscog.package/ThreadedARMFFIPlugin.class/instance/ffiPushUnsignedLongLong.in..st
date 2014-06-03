marshalling
ffiPushUnsignedLongLong: value in: calloutState
	<var: #value type: #usqLong>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	calloutState integerRegisterIndex < (NumIntRegArgs - 1)
		ifTrue:
			[calloutState integerRegisterIndex: (calloutState integerRegisterIndex + 1 bitClear: 1).
			 calloutState integerRegisters at: calloutState integerRegisterIndex put: (self cCoerceSimple: value to: #usqInt).
			 calloutState integerRegisters at: calloutState integerRegisterIndex + 1 put: (self cCoerceSimple: value >> 32 to: #usqInt).
			 calloutState integerRegisterIndex: calloutState integerRegisterIndex + 2]
		ifFalse:
			[calloutState currentArg + 8 > calloutState limit ifTrue: [^FFIErrorCallFrameTooBig].
			 calloutState integerRegisterIndex: NumIntRegArgs.
			 interpreterProxy
				longAt: calloutState currentArg put: (self cCoerceSimple: value to: #usqInt);
				longAt: calloutState currentArg + 4 put: (self cCoerceSimple: value >> 32 to: #usqInt).
			 calloutState currentArg: calloutState currentArg + 8].
	^0
