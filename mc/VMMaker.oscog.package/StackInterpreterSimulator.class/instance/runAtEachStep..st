testing
runAtEachStep: aBlock
	self initStackPages.
	self loadInitialContext.
	self internalizeIPandSP.
	self fetchNextBytecode.
	[true] whileTrue:
		[self assertValidExecutionPointers.
		 aBlock value: currentBytecode.
		 self dispatchOn: currentBytecode in: BytecodeTable.
		 self incrementByteCount].
	localIP := localIP - 1.
	"undo the pre-increment of IP before returning"
	self externalizeIPandSP