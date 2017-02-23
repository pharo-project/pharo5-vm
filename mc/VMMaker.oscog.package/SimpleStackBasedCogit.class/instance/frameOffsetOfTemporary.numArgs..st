bytecode generator support
frameOffsetOfTemporary: index numArgs: numArgs
	<inline: true>
	^index < numArgs
		ifTrue: [FoxCallerSavedIP + ((numArgs - index) * objectMemory wordSize)]
		ifFalse: [FoxMFReceiver - objectMemory wordSize + ((numArgs - index) * objectMemory wordSize)]