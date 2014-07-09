assembly
sendToAbsentDynamicSuperclass: selector numArgs: numArgs
	^encoder genSendAbsentDynamicSuper: (encoder sharableLitIndex: selector) numArgs: numArgs