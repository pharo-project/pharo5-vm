initialization
initializeInterpreter: bytesToShift
	"Initialize Interpreter state before starting execution of a new image."
	interpreterProxy := self sqGetInterpreterProxy.
	self dummyReferToProxy.
	objectMemory initializeObjectMemory: bytesToShift.
	self checkAssumedCompactClasses.
	self initializeExtraClassInstVarIndices.
	method := newMethod := objectMemory nilObject.
	self cCode: '' inSmalltalk:
		[breakSelectorLength ifNil:
			[breakSelectorLength := objectMemory minSmallInteger]].
	methodDictLinearSearchLimit := 8.
	self initialCleanup.
	LowcodeVM ifTrue: [ self setupNativeStack ].
	profileSemaphore := profileProcess := profileMethod := objectMemory nilObject.
	interruptKeycode := 2094. "cmd-. as used for Mac but no other OS"
	[globalSessionID = 0] whileTrue:
		[globalSessionID := self
								cCode: [(self time: #NULL) + self ioMSecs]
								inSmalltalk: [(Random new next * SmallInteger maxVal) asInteger]]