testing
test1
	self initStackPages.
	self loadInitialContext.
	transcript clear.
	byteCount := 0.
	breakCount := -1.
	self setBreakSelector: #blockCopy:.
	quitBlock := [^self].
	printSends := printReturns := true.
	self internalizeIPandSP.
	self fetchNextBytecode.
	[true] whileTrue:
		[self assertValidExecutionPointers.
		 "byteCount >= 22283 ifTrue:
			[(self checkIsStillMarriedContext: 22186072 currentFP: localFP) ifFalse:
				[self halt]]."
		 (printBytecodeAtEachStep
		  "and: [self isMarriedOrWidowedContext: 22189568]") ifTrue:
			["| thePage |
			 thePage := stackPages stackPageFor: (self frameOfMarriedContext: 22189568).
			 thePage == stackPage
				ifTrue: [self shortPrintFrameAndCallers: localFP SP: localSP]
				ifFalse: [self shortPrintFrameAndCallers: thePage headFrameFP SP: thePage headFrameSP]."
			 self printCurrentBytecodeOn: Transcript.
			 Transcript cr; flush].

		 self dispatchOn: currentBytecode in: BytecodeTable.
		 self incrementByteCount.
		 byteCount = breakCount ifTrue:
			["printFrameAtEachStep := true."
			 printSends := printBytecodeAtEachStep := true.
			 self halt: 'hit breakCount break-point']].
	self externalizeIPandSP