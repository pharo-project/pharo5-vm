testing
logOfBytesVerify: nBytes fromFileNamed: fileName fromStart: loggingStart
	"Verify a questionable interpreter against a successful run"
	"self logOfBytesVerify: 10000 fromFileNamed: 'clone32Bytecodes.log' "
	
	| logFile rightByte prevCtxt |
	logFile := (FileStream readOnlyFileNamed: fileName) binary.
	transcript clear.
	byteCount := 0.
	quitBlock := [^ self].
	self internalizeIPandSP.
	self fetchNextBytecode.
	prevCtxt := 0.  prevCtxt := prevCtxt.
	[byteCount < nBytes] whileTrue:
		[
"
byteCount > 14560 ifTrue:
[self externalizeIPandSP.
prevCtxt = activeContext ifFalse:
 [prevCtxt := activeContext.
 transcript cr; nextPutAll: (self printTop: 2); endEntry].
transcript cr; print: byteCount; nextPutAll: ': ' , (activeContext hex); space;
 print: (instructionPointer - method - (BaseHeaderSize - 2));
 nextPutAll: ': <' , (self byteAt: localIP) hex , '>'; space;
 nextPutAll: (self symbolic: currentBytecode at: localIP inMethod: method); space;
 print: (self stackPointerIndex - TempFrameStart + 1); endEntry.
byteCount = 14590 ifTrue: [self halt]].
"
		loggingStart >= byteCount ifTrue:
			[rightByte := logFile next.
			 currentBytecode = rightByte ifFalse:
				[self halt: 'halt at ', byteCount printString]].
		self dispatchOn: currentBytecode in: BytecodeTable.
		byteCount := byteCount + 1.
		byteCount \\ 10000 = 0 ifTrue: [self fullDisplayUpdate]].
	self externalizeIPandSP.
	logFile close.
	self inform: nBytes printString , ' bytecodes verfied.'