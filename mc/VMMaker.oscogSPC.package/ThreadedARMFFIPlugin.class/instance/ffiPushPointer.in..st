marshalling
ffiPushPointer: pointer in: calloutState
	<var: #pointer type: #'void *'>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	calloutState integerRegisterIndex < NumIntRegArgs
		ifTrue:
			[calloutState integerRegisters at: calloutState integerRegisterIndex put: pointer asInteger.
			 calloutState integerRegisterIndex: calloutState integerRegisterIndex + 1]
		ifFalse:
			[calloutState currentArg + 4 > calloutState limit ifTrue:
				[^FFIErrorCallFrameTooBig].
			 interpreterProxy longAt: calloutState currentArg put: pointer.
			 calloutState currentArg: calloutState currentArg + 4].
	^0