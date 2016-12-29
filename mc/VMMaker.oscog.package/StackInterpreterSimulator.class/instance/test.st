testing
test
	self initStackPages.
	self loadInitialContext.
	transcript clear.
	byteCount := 0.
	breakCount := -1.
	quitBlock := [^self close].
	printSends := printReturns := true.
	self internalizeIPandSP.
	self fetchNextBytecode.
	[true] whileTrue:
		[self assertValidExecutionPointers.
		 printFrameAtEachStep ifTrue:
			[self printFrame: localFP WithSP: localSP].
		 printBytecodeAtEachStep ifTrue:
			[self printCurrentBytecodeOn: Transcript.
			 Transcript cr; flush].
		 self dispatchOn: currentBytecode in: BytecodeTable.
		 self incrementByteCount.
		 byteCount = breakCount ifTrue:
			["printFrameAtEachStep :=" printBytecodeAtEachStep := true.
			 self halt: 'hit breakCount break-point']].
	self externalizeIPandSP