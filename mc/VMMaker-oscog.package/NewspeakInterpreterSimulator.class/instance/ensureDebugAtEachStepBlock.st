testing
ensureDebugAtEachStepBlock
	atEachStepBlock := [printContextAtEachStep ifTrue:
							[self printContext: activeContext WithSP: localSP].
						 printBytecodeAtEachStep ifTrue:
							[self printCurrentBytecodeOn: transcript.
							 transcript cr; flush].
						 byteCount = breakCount ifTrue:
							["printContextAtEachStep :=" printBytecodeAtEachStep := true]]