testing
logOfSendsVerify: nSends fromFileNamed: fileName fromStart: loggingStart
	"Write a log file for testing a flaky interpreter on the same image"
	"self logOfSendsWrite: 10000 toFileNamed: 'clone32Messages.log' "
	
	| logFile priorFrame rightSelector prevCtxt |
	logFile := FileStream readOnlyFileNamed: fileName.
	transcript clear.
	byteCount := 0.
	sendCount := 0.
	priorFrame := localFP.
	quitBlock := [^ self].
	self initStackPages.
	self loadInitialContext.
	self internalizeIPandSP.
	self fetchNextBytecode.
	prevCtxt := 0.  prevCtxt := prevCtxt.
	[sendCount < nSends] whileTrue:
		[
"
byteCount>500 ifTrue:
[byteCount>550 ifTrue: [self halt].
self externalizeIPandSP.
prevCtxt = localFP ifFalse:
 [prevCtxt := localFP.
 transcript cr; nextPutAll: (self printTop: 2); endEntry].
transcript cr; print: byteCount; nextPutAll: ': ' , (localFP hex); space;
 print: (instructionPointer - method - (BaseHeaderSize - 2));
 nextPutAll: ': <' , (self byteAt: localIP) hex , '>'; space;
 nextPutAll: (self symbolic: currentBytecode at: localIP inMethod: method); space;
 print: (self stackPointerIndex - TempFrameStart + 1); endEntry.
].
"
		self dispatchOn: currentBytecode in: BytecodeTable.
		localFP = priorFrame ifFalse:
			[sendCount := sendCount + 1.
			 loggingStart >= sendCount ifTrue:
				[rightSelector := logFile nextLine.
				 (self stringOf: messageSelector) = rightSelector ifFalse:
					[self halt: 'halt at ', sendCount printString]].
			priorFrame := localFP].
		self incrementByteCount].
	self externalizeIPandSP.
	logFile close.
	self inform: nSends printString , ' sends verfied.'