testing
runUntilDivergenceFromTrace: aSequence
	self internalizeIPandSP.
	self fetchNextBytecode.
	[true] whileTrue:
		[(aSequence at: byteCount + 1) ~~ (BytecodeTable at: currentBytecode + 1) ifTrue:
			[self halt: byteCount printString, ' ', (aSequence at: byteCount + 1), ' ~~ ', (BytecodeTable at: currentBytecode + 1)].
		 self dispatchOn: currentBytecode in: BytecodeTable.
		 byteCount := byteCount + 1].
	localIP := localIP - 1.
	"undo the pre-increment of IP before returning"
	self externalizeIPandSP