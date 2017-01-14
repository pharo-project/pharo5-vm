debugging
picInterpretAbortOffset
	"Answer the start of the abort sequence for invoking the interpreter in a closed PIC."
	^self interpretOffset
	 - (backEnd hasLinkRegister
		ifTrue: [backEnd pushLinkRegisterByteSize + backEnd callInstructionByteSize]
		ifFalse: [backEnd callInstructionByteSize])