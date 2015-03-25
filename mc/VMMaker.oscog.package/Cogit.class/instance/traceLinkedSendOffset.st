debugging
traceLinkedSendOffset
	<api>
	^cmNoCheckEntryOffset
	 + backEnd callInstructionByteSize
	 + (backEnd hasLinkRegister
		ifTrue: [backEnd pushLinkRegisterByteSize]
		ifFalse: [0])