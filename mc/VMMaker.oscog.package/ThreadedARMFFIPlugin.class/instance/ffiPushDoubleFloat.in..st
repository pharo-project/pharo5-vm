marshalling
ffiPushDoubleFloat: value in: calloutState
	<var: #value type: #double>
	<var: #calloutState type: #'CalloutState *'>
	<inline: true>

	calloutState floatRegisterIndex < (NumFloatRegArgs - 1)
		ifTrue:
			[(calloutState floatRegisterIndex bitAnd: 1) = 1
				ifTrue: 
					[calloutState backfillFloatRegisterIndex: calloutState floatRegisterIndex.
					 calloutState floatRegisterIndex: (calloutState floatRegisterIndex + 1)].
		  	 (self cCoerceSimple: (self addressOf: (calloutState floatRegisters at: calloutState floatRegisterIndex)) 
				 	to: 'double*')
						at: 0
						put: value.
			 calloutState floatRegisterIndex: calloutState floatRegisterIndex + 2]
		ifFalse:
			[calloutState currentArg + 8 > calloutState limit ifTrue:
				[^FFIErrorCallFrameTooBig].
			 calloutState floatRegisterIndex: NumFloatRegArgs.
			 interpreterProxy storeFloatAtPointer: calloutState currentArg from: value.
			 calloutState currentArg: calloutState currentArg + 8].
	^0