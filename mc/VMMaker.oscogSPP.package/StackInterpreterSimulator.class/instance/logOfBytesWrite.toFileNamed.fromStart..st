testing
logOfBytesWrite: nBytes toFileNamed: fileName fromStart: loggingStart
	"Write a log file for testing a flaky interpreter on the same image"
	"self logOfBytesWrite: 10000 toFileNamed: 'clone32Bytecodes.log' "
	
	| logFile |
	logFile := (FileStream newFileNamed: fileName) binary.
	transcript clear.
	byteCount := 0.
	quitBlock := [^self close].
	self initStackPages.
	self loadInitialContext.
	self internalizeIPandSP.
	self fetchNextBytecode.
	[byteCount < nBytes] whileTrue:
		[byteCount >= loggingStart ifTrue:
			[logFile nextWordPut: currentBytecode].
		self dispatchOn: currentBytecode in: BytecodeTable.
		self incrementByteCount].
	self externalizeIPandSP.
	logFile close