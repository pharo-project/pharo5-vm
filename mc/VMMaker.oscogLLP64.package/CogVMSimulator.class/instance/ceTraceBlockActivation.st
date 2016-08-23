debug support
ceTraceBlockActivation
	cogit printOnTrace ifTrue:
		[transcript print: byteCount; nextPut: $/; print: (sendCount := sendCount + 1); space].
	cogit assertCStackWellAligned.
	super ceTraceBlockActivation.
	^#continue