initialization
initialize
	"We can put all initializatins that set something to 0 or to false here.
	 In C all global variables are initialized to 0, and 0 is false."
	freeLists := CArrayAccessor on: (Array new: NumFreeLists withAll: 0).
	remapBuffer := Array new: RemapBufferSize.
	remapBufferCount := 0.
	freeListsMask := totalFreeOldSpace := lowSpaceThreshold := 0.
	checkForLeaks := 0.
	needGCFlag := signalLowSpace := scavengeInProgress := false.
	becomeEffectsFlags := 0.
	statScavenges := statIncrGCs := statFullGCs := 0.
	statScavengeGCUsecs := statIncrGCUsecs := statFullGCUsecs := 0.
	statSGCDeltaUsecs := statIGCDeltaUsecs := statFGCDeltaUsecs := 0.

	"We can also initialize here anything that is only for simulation."
	heapMap := self wordSize = 4 ifTrue: [CogCheck32BitHeapMap new]