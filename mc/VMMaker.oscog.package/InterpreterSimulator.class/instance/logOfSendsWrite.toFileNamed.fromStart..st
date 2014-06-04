testing
logOfSendsWrite: nSends toFileNamed: fileName fromStart: loggingStart
	"Write a log file for testing a flaky interpreter on the same image"
	"self logOfSendsWrite: 10000 toFileNamed: 'clone32Messages.log' "
	
	| logFile priorContext |
	logFile := FileStream newFileNamed: fileName.
	transcript clear.
	byteCount := 0.
	sendCount := 0.
	priorContext := activeContext.
	quitBlock := [^ self].
	self internalizeIPandSP.
	self fetchNextBytecode.
	[sendCount < nSends] whileTrue:
		[self dispatchOn: currentBytecode in: BytecodeTable.
		activeContext == priorContext ifFalse:
			[sendCount >= loggingStart ifTrue:
				[sendCount := sendCount + 1.
				 logFile nextPutAll: (self stringOf: messageSelector); cr].
			priorContext := activeContext].
		byteCount := byteCount + 1.
		byteCount \\ 10000 = 0 ifTrue: [self fullDisplayUpdate]].
	self externalizeIPandSP.
	logFile close