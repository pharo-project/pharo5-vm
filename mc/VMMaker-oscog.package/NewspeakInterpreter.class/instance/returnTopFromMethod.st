return bytecodes
returnTopFromMethod
	localReturnContext := self sender.
	localReturnValue := self internalStackTop.
	self commonReturn.