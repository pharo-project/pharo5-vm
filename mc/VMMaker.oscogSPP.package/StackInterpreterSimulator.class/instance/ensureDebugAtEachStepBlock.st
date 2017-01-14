testing
ensureDebugAtEachStepBlock
	atEachStepBlock := [printFrameAtEachStep ifTrue:
							[self printFrame: localFP WithSP: localSP].
						 printBytecodeAtEachStep ifTrue:
							[self printCurrentBytecodeOn: transcript.
							 transcript cr; flush].
						 byteCount = breakCount ifTrue:
							["printFrameAtEachStep :=" printBytecodeAtEachStep := true]]