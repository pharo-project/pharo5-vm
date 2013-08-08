testing
logOfSendsWrite: nSends toFileNamed: fileName fromStart: loggingStart
	"Write a log file for testing a flaky interpreter on the same image"
	"self logOfSendsWrite: 10000 toFileNamed: 'clone32Messages.log' "
	
	| logFile priorFrame |
	logFile := FileStream newFileNamed: fileName.
	transcript clear.
	byteCount := 0.
	sendCount := 0.
	priorFrame := localFP.
	quitBlock := [^ self].
	self initStackPages.
	self loadInitialContext.
	self internalizeIPandSP.
	self fetchNextBytecode.
	[sendCount < nSends] whileTrue:
		[self dispatchOn: currentBytecode in: BytecodeTable.
		localFP = priorFrame ifFalse:
			[sendCount >= loggingStart ifTrue:
				[sendCount := sendCount + 1.
				logFile nextPutAll: (self stringOf: messageSelector); cr].
			priorFrame := localFP].
		self incrementByteCount].
	self externalizeIPandSP.
	logFile close