marshalling
ffiPushDoubleFloat: value in: calloutState
	<var: #value type: #double>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>

	calloutState floatRegisterIndex < NumFloatRegArgs
		ifTrue:
			[calloutState floatRegisters at: calloutState floatRegisterIndex put: value.
			 calloutState incrementFloatRegisterIndex]
		ifFalse:
			[calloutState currentArg + WordSize > calloutState limit ifTrue:
				[^FFIErrorCallFrameTooBig].
			 interpreterProxy storeFloatAtPointer: calloutState currentArg from: value.
			 calloutState currentArg: calloutState currentArg + WordSize].
	^0