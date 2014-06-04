testing
runAtEachStep: aBlock
	self internalizeIPandSP.
	self fetchNextBytecode.
	[true] whileTrue:
		[aBlock value: currentBytecode.
		 self dispatchOn: currentBytecode in: BytecodeTable.
		 byteCount := byteCount + 1].
	localIP := localIP - 1.
	"undo the pre-increment of IP before returning"
	self externalizeIPandSP