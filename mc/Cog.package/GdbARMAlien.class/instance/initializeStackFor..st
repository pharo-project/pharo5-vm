processor setup
initializeStackFor: aCogit
	"Different cpus need different stack alignment etc, so handle the details here."
	aCogit setStackAlignment: 8 expectedSPOffset: 0 expectedFPOffset: 0.
	PostBuildStackDelta := 0