initialization
initializeInterpreter: bytesToShift 
	"Initialize Interpreter state before starting execution of a new image."
	interpreterProxy := self sqGetInterpreterProxy.
	self dummyReferToProxy.
	self initializeObjectMemory: bytesToShift.
	self initCompilerHooks.
	self checkAssumedCompactClasses.
	metaclassSizeBits := self sizeBitsOf: (self fetchClassOfNonImm: (self splObj: ClassArray)).	"determine actual (Metaclass instSize * 4)"
	activeContext := nilObj.
	theHomeContext := nilObj.
	method := nilObj.
	receiver := nilObj.
	messageSelector := nilObj.
	newMethod := nilObj.
	lkupClass := nilObj.
	receiverClass := nilObj.
	self flushMethodCache.
	self loadInitialContext.
	self initialCleanup.
	interruptCheckCounter := 0.
	interruptCheckCounterFeedBackReset := 1000.
	interruptChecksEveryNms := 1.
	nextProfileTick := 0.
	profileSemaphore := nilObj.
	profileProcess := nilObj.
	profileMethod := nilObj.
	nextPollTick := 0.
	nextWakeupTick := 0.
	lastTick := 0.
	interruptKeycode := 2094. "cmd-. as used for Mac but no other OS"
	interruptPending := false.
	semaphoresUseBufferA := true.
	semaphoresToSignalCountA := 0.
	semaphoresToSignalCountB := 0.
	deferDisplayUpdates := false.
	pendingFinalizationSignals := statPendingFinalizationSignals := 0.
	globalSessionID := 0.
	[globalSessionID = 0]
		whileTrue: [globalSessionID := self
						cCode: 'time(NULL) + ioMSecs()'
						inSmalltalk: [(Random new next * SmallInteger maxVal) asInteger]].
	jmpDepth := 0.
	jmpMax := MaxJumpBuf. "xxxx: Must match the definition of jmpBuf and suspendedCallbacks"
	statQuickCheckForEvents := 0.
	statCheckForEvents := 0.
	statProcessSwitch := 0.
	statIOProcessEvents := 0
