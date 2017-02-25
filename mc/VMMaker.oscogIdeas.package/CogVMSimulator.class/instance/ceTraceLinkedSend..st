debug support
ceTraceLinkedSend: theReceiver
	(sendCount := sendCount + 1) \\ 500 = 0 ifTrue:
		[self changed: #byteCountText].
	cogit printOnTrace ifTrue:
		[transcript print: byteCount; nextPut: $/; print: sendCount; space].
	cogit assertCStackWellAligned.
	super ceTraceLinkedSend: theReceiver.
	^#continue