bytecode generators
frameOffsetOfTemporary: index
	^index < methodOrBlockNumArgs
		ifTrue: [FoxCallerSavedIP + ((methodOrBlockNumArgs - index) * BytesPerWord)]
		ifFalse: [FoxMFReceiver - BytesPerWord + ((methodOrBlockNumArgs - index) * BytesPerWord)]