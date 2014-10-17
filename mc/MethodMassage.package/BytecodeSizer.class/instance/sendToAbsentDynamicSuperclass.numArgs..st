assembly
sendToAbsentDynamicSuperclass: selector numArgs: numArgs
	^encoder sizeSendAbsentDynamicSuper: (encoder sharableLitIndex: selector) numArgs: numArgs