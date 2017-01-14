initialization
initialize
	<doNotGenerate>
	"Initialize NewObjectMemory when simulating the VM inside Smalltalk."
	super initialize.
	checkForLeaks := fullGCLock := 0.
	needGCFlag := false.
	heapMap := CogCheck32BitHeapMap new