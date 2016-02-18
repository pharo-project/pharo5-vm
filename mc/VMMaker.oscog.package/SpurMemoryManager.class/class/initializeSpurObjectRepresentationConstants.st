class initialization
initializeSpurObjectRepresentationConstants
	"SpurMemoryManager initializeSpurObjectRepresentationConstants"
	BecamePointerObjectFlag := 1.
	BecameCompiledMethodFlag := 2.
	OldBecameNewFlag := 4.
	BecameActiveClassFlag := 8 "For flushing method caches"