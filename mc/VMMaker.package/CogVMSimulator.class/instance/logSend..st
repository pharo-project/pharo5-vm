debugging traps
logSend: oop
	sendCount := sendCount + 1.
	printSends ifTrue:
		[transcript print: byteCount; nextPut: $/; print: sendCount; space.
		 self printStringOf: oop.
		 transcript cr; flush]