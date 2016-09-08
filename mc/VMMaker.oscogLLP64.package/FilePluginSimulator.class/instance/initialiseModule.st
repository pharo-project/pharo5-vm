initialize-release
initialiseModule
	"See FilePluginSimulator>>sqFileStdioHandlesInto:"
	(openFiles := Dictionary new)
		at: 0 put: (FakeStdinStream for: interpreterProxy interpreter); "stdin"
		at: 1 put: Transcript; "stdout"
		at: 2 put: Transcript. "stderr"
	states := IdentityDictionary new.
	maxOpenFiles := VMClass initializationOptions at: #MaxFileDescriptors ifAbsent: [1024].
	^super initialiseModule