simulation
sqFileStdioHandlesInto: anArray
	(interpreterProxy transcript ~~ Transcript
	 or: [UIManager default confirm: 'clear transcript?']) ifTrue:
		[interpreterProxy transcript clear].
	"See FilePluginSimulator>>initialiseModule"
	anArray
		at: 1 put: 0;
		at: 2 put: 1;
		at: 3 put: 2.
	^7