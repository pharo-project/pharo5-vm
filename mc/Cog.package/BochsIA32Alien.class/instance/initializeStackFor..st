processor setup
initializeStackFor: aCogit
"Different cpus need different stack alignment etc, so handle the details here."
	"This is for testing.  On many OS's the stack must remain aligned;
	 e.g. IA32 using SSE requires 16 byte alignment."
	| stackAlignment |
	stackAlignment := 16.
	aCogit setStackAlignment: stackAlignment expectedSPOffset: 0 expectedFPOffset: 8.
	PostBuildStackDelta := stackAlignment > 8
								ifTrue: [stackAlignment - 8]
								ifFalse: [0]