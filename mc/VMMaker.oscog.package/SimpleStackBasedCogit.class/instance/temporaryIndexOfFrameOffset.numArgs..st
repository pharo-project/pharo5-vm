bytecode generator support
temporaryIndexOfFrameOffset: offset numArgs: numArgs
	"For assert checking..."
	^numArgs - ((offset < 0 "args are > 0"
					ifTrue: [offset - FoxMFReceiver + objectMemory wordSize]
					ifFalse: [offset - FoxCallerSavedIP]) / objectMemory wordSize)