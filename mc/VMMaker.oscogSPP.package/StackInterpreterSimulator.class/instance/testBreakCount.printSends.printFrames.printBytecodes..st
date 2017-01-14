testing
testBreakCount: breakCount printSends: shouldPrintSends printFrames: shouldPrintFrames printBytecodes: shouldPrintBytecodes
	self initStackPages.
	self loadInitialContext.
	transcript clear.
	byteCount := 0.
	quitBlock := [^self close].
	printSends := true & shouldPrintSends. "true & foo allows evaluating printFoo := true in the debugger"
	printFrameAtEachStep := true & shouldPrintFrames.
	printBytecodeAtEachStep := true & shouldPrintBytecodes.
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