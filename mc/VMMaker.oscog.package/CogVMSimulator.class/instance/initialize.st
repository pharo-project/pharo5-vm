initialization
initialize
	"Initialize the CogVMSimulator when running the interpreter inside Smalltalk.  The
	 primary responsibility of this method is to allocate Smalltalk Arrays for variables
	 that will be declared as statically-allocated global arrays in the translated code."
	super initialize.

	transcript := Transcript.

	objectMemory ifNil:
		[objectMemory := self class objectMemoryClass simulatorClass new].
	cogit ifNil:
		[cogit := self class cogitClass new setInterpreter: self].
	objectMemory coInterpreter: self cogit: cogit.

	cogit numRegArgs > 0 ifTrue:
		[debugStackDepthDictionary := Dictionary new].

	cogThreadManager ifNotNil:
		[super initialize].

	self assert: ConstMinusOne = (objectMemory integerObjectOf: -1).

	cogMethodZone := cogit methodZone. "Because Slang can't remove intermediate implicit receivers (cogit methodZone foo doesn't reduce to foo())"
	enableCog := true.

	methodCache := Array new: MethodCacheSize.
	nsMethodCache := Array new: NSMethodCacheSize.
	atCache := nil.
	self flushMethodCache.
	cogCompiledCodeCompactionCalledFor := false.
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
	desiredNumStackPages := desiredEdenBytes := desiredCogCodeSize := 0.
	"This is initialized on loading the image, but convenient for testing stack page values..."
	numStackPages := self defaultNumStackPages. 
	startMicroseconds := self ioUTCStartMicroseconds.
	maxLiteralCountForCompile := MaxLiteralCountForCompile.
	minBackwardJumpCountForCompile := MinBackwardJumpCountForCompile.
	flagInterpretedMethods := false.

	"initialize InterpreterSimulator variables used for debugging"
	byteCount := lastPollCount := sendCount := lookupCount := 0.
	quitBlock := [^ self].
	traceOn := true.
	printSends := printFrameAtEachStep := printBytecodeAtEachStep := false.
	myBitBlt := BitBltSimulator new setInterpreter: self.
	displayForm := fakeForm := 'Display has not yet been installed' asDisplayText form.
	eventQueue := SharedQueue new.
	suppressHeartbeatFlag := deferSmash := deferredSmash := false.
	systemAttributes := Dictionary new.
	primTraceLog := CArrayAccessor on: (Array new: 256 withAll: 0).
	primTraceLogIndex := 0.
	traceLog := CArrayAccessor on: (Array new: TraceBufferSize withAll: 0).
	traceLogIndex := 0.
	traceSources := TraceSources.
	statCodeCompactionCount := 0.
	statCodeCompactionUsecs := 0.
	extSemTabSize := 256