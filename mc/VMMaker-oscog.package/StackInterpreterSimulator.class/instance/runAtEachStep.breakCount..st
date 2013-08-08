testing
runAtEachStep: aBlock breakCount: breakCount
	self initStackPages.
	self loadInitialContext.
	self internalizeIPandSP.
	self fetchNextBytecode.
	[true] whileTrue:
		[self assertValidExecutionPointers.
		 aBlock value: currentBytecode.
		 self dispatchOn: currentBytecode in: BytecodeTable.
		 self incrementByteCount.
		 byteCount = breakCount ifTrue:
			[self halt]].
	localIP := localIP - 1.
	"undo the pre-increment of IP before returning"
	self externalizeIPandSP