marshalling
ffiPushSingleFloat: value in: calloutState
	<var: #value type: #float>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>

	calloutState floatRegisterIndex < NumFloatRegArgs
		ifTrue:
			[calloutState floatRegisters at: calloutState floatRegisterIndex put: value.
			 calloutState floatRegisterIndex: calloutState floatRegisterIndex + 1]
		ifFalse:
			[calloutState currentArg + WordSize > calloutState limit ifTrue:
				[^FFIErrorCallFrameTooBig].
			 interpreterProxy storeFloatAtPointer: calloutState currentArg from: value.
			 calloutState currentArg: calloutState currentArg + WordSize].
	^0