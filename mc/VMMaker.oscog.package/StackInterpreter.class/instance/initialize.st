initialization
initialize
	"Here we can initialize the variables C initializes to zero.  #initialize methods do /not/ get translated."
	checkAllocFiller := false. "must precede initializeObjectMemory:"
	primFailCode := 0.
	stackLimit := 0. "This is also the initialization flag for the stack system."
	stackPage := overflowedPage := 0.
	extraFramesToMoveOnOverflow := 0.
	bytecodeSetSelector := 0.
	highestRunnableProcessPriority := 0.
	nextProfileTick := 0.
	nextPollUsecs := 0.
	nextWakeupUsecs := 0.
	tempOop := tempOop2 := tempOop3 := theUnknownShort := 0.
	interruptPending := false.
	inIOProcessEvents := 0.
	fullScreenFlag := 0.
	deferDisplayUpdates := false.
	displayBits := displayWidth := displayHeight := displayDepth := 0.
	pendingFinalizationSignals := statPendingFinalizationSignals := 0.
	globalSessionID := 0.
	jmpDepth := 0.
	longRunningPrimitiveStartUsecs := longRunningPrimitiveStopUsecs := 0.
	maxExtSemTabSizeSet := false.
	debugCallbackInvokes := debugCallbackPath := debugCallbackReturns := 0.
	statForceInterruptCheck := statStackOverflow := statCheckForEvents :=
	statProcessSwitch := statIOProcessEvents := statStackPageDivorce :=
	statIdleUsecs := 0