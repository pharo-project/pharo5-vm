testing
test
	transcript clear.
	byteCount := 0.
	quitBlock := [^ self].
	self internalizeIPandSP.
	self fetchNextBytecode.
	[true] whileTrue:
		[self dispatchOn: currentBytecode in: BytecodeTable.
		byteCount := byteCount + 1.
		byteCount \\ 10000 = 0 ifTrue: [self fullDisplay]].
	self externalizeIPandSP.
