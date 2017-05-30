marshalling
ffiPushSingleFloat: value in: calloutState
	<var: #value type: #float>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>

	calloutState floatRegisterIndex < NumFloatRegArgs
		ifTrue:
			[(self cCoerce: calloutState floatRegisters + calloutState floatRegisterIndex to: #'float *') at: 0 put: value.
			 calloutState incrementFloatRegisterIndex]
		ifFalse:
			[calloutState currentArg + WordSize > calloutState limit ifTrue:
				[^FFIErrorCallFrameTooBig].
			 interpreterProxy storeFloatAtPointer: calloutState currentArg from: value.
			 calloutState currentArg: calloutState currentArg + WordSize].
	^0