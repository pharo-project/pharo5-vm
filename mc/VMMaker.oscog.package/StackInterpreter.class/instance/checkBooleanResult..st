arithmetic primitive support
checkBooleanResult: result
	self successful
		ifTrue: [self pushBool: result]
		ifFalse: [self unPop: 2]