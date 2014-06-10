testing
test1
	| breakCount printBytecodeAtEachStep |
	transcript clear.
	byteCount := 0.
	breakCount := -1.
	breakSelector := #openOn:context:label:contents:fullView:.
	quitBlock := [^self].
	printSends := true.
	printBytecodeAtEachStep := false.
	self internalizeIPandSP.
	self fetchNextBytecode.
	[true] whileTrue:
		[printBytecodeAtEachStep ifTrue:
			[self printCurrentBytecodeOn: Transcript.
			 Transcript cr; flush].

		 self dispatchOn: currentBytecode in: BytecodeTable.

		 byteCount := byteCount + 1.
		 byteCount = breakCount ifTrue:
			["printFrameAtEachStep :=" printBytecodeAtEachStep := true.
			 self halt: 'hit breakCount break-point'].
		 byteCount \\ 10000 = 0 ifTrue: [self fullDisplay]].
	self externalizeIPandSP