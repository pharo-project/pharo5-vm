initialization
initialize
	"Initialize the StackInterpreterSimulator when running the interpreter
	 inside Smalltalk. The primary responsibility of this method is to allocate
	 Smalltalk Arrays for variables that will be declared as statically-allocated
	 global arrays in the translated code."
	super initialize.

	bootstrapping := false.
	transcript := Transcript.

	objectMemory ifNil:
		[objectMemory := self class objectMemoryClass simulatorClass new].
	objectMemory coInterpreter: self.

	self assert: ConstMinusOne = (objectMemory integerObjectOf: -1).

	methodCache := Array new: MethodCacheSize.
	nsMethodCache := Array new: NSMethodCacheSize.
	atCache := Array new: AtCacheTotalSize.
	self flushMethodCache.
	gcSemaphoreIndex := 0.
	externalSemaphoreSignalRequests := externalSemaphoreSignalResponses := #().
	externalPrimitiveTable := CArrayAccessor on: (Array new: MaxExternalPrimitiveTableSize).
	externalPrimitiveTableFirstFreeIndex := 0.
	primitiveTable := self class primitiveTable copy.
	mappedPluginEntries := OrderedCollection new.
	objectMemory hasSpurMemoryManagerAPI
		ifTrue:
			[primitiveAccessorDepthTable := Array new: primitiveTable size.
			 pluginList := {}.
			 self loadNewPlugin: '']
		ifFalse:
			[pluginList := {'' -> self }].
	desiredNumStackPages := desiredEdenBytes := 0.
	"This is initialized on loading the image, but convenient for testing stack page values..."
	numStackPages := self defaultNumStackPages. 
	startMicroseconds := lastYieldMicroseconds := self ioUTCStartMicroseconds.

	"initialize InterpreterSimulator variables used for debugging"
	byteCount := sendCount := lookupCount := 0.
	quitBlock := [^self close].
	traceOn := true.
	printSends := printReturns := printFrameAtEachStep := printBytecodeAtEachStep := false.
	myBitBlt := BitBltSimulator new setInterpreter: self.
	displayForm := fakeForm := 'Display has not yet been installed' asDisplayText form.
	eventQueue := SharedQueue new.
	suppressHeartbeatFlag := false.
	systemAttributes := Dictionary new.
	extSemTabSize := 256.
	disableBooleanCheat := false.
	assertVEPAES := true. "a flag so the assertValidExecutionPointers can be disabled for simulation speed"