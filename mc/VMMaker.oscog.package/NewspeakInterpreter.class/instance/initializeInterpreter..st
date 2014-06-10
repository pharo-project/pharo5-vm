initialization
initializeInterpreter: bytesToShift 
	"Initialize NewspeakInterpreter state before starting execution of a new image."
	interpreterProxy := self sqGetInterpreterProxy.
	self dummyReferToProxy.
	self initializeObjectMemory: bytesToShift.
	self checkAssumedCompactClasses.
	primFailCode := 0.
	self initializeExtraClassInstVarIndices.
	activeContext := nilObj.
	theHomeContext := nilObj.
	method := nilObj.
	receiver := nilObj.
	messageSelector := nilObj.
	newMethod := nilObj.
	lkupClass := nilObj.
	self flushMethodCache.
	self flushAtCache.
	self loadInitialContext.
	self initialCleanup.
	interruptCheckCounter := 0.
	interruptCheckCounterFeedBackReset := 1000.
	interruptChecksEveryNms := 1.
	nextPollTick := 0.
	nextWakeupTick := 0.
	lastTick := 0.
	interruptKeycode := 2094. "cmd-. as used for Mac but no other OS"
	interruptPending := false.
	deferDisplayUpdates := false.
	pendingFinalizationSignals := 0.
	globalSessionID := 0.
	[globalSessionID = 0]
		whileTrue: [globalSessionID := self
						cCode: 'time(NULL) + ioMSecs()'
						inSmalltalk: [(Random new next * SmallInteger maxVal) asInteger]]