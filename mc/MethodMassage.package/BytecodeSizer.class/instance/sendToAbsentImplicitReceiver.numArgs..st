assembly
sendToAbsentImplicitReceiver: selector numArgs: numArgs
	^encoder sizeSendAbsentImplicit: (encoder sharableLitIndex: selector) numArgs: numArgs