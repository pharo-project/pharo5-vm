assembly
sendToAbsentImplicitReceiver: selector numArgs: numArgs
	^encoder genSendAbsentImplicit: (encoder sharableLitIndex: selector) numArgs: numArgs