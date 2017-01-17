return bytecodes
returnNil
	localReturnContext := self sender.
	localReturnValue := nilObj.
	self commonReturn.