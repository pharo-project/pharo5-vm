bytecode generator support
frameOffsetOfTemporary: index
	^index < methodOrBlockNumArgs
		ifTrue: [FoxCallerSavedIP + ((methodOrBlockNumArgs - index) * objectMemory wordSize)]
		ifFalse: [FoxMFReceiver - objectMemory wordSize + ((methodOrBlockNumArgs - index) * objectMemory wordSize)]