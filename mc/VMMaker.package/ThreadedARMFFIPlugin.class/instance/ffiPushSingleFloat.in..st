marshalling
ffiPushSingleFloat: value in: calloutState
	<var: #value type: #float>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>
	calloutState floatRegisterIndex < NumFloatRegArgs
		ifTrue: 
			[calloutState backfillFloatRegisterIndex > 0
				ifTrue: 
					[calloutState floatRegisters at: calloutState backfillFloatRegisterIndex  put: value.
					 calloutState backfillFloatRegisterIndex: 0]
				ifFalse: 
					[calloutState floatRegisters at: calloutState floatRegisterIndex  put: value.
					 calloutState floatRegisterIndex: calloutState floatRegisterIndex + 1]]
		ifFalse:
			[calloutState currentArg + 4 > calloutState limit ifTrue:
				[^FFIErrorCallFrameTooBig].
			 interpreterProxy storeSingleFloatAtPointer: calloutState currentArg from: value.
			 calloutState currentArg: calloutState currentArg + 4].
	^0