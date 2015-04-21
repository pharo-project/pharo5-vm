testing
runForNBytes: nBytecodes 
	"Do nByteCodes more bytecode dispatches.
	Keep byteCount up to date.
	This can be run repeatedly."
	| endCount |
	self initStackPages.
	self loadInitialContext.
	endCount := byteCount + nBytecodes.
	self internalizeIPandSP.
	self fetchNextBytecode.
	[byteCount < endCount] whileTrue:
		[self dispatchOn: currentBytecode in: BytecodeTable.
		 self incrementByteCount].
	localIP := localIP - 1.
	"undo the pre-increment of IP before returning"
	self externalizeIPandSP