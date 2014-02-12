initialization
initialize
	"Initialize the StackInterpreterSimulator when running the interpreter
	 inside Smalltalk. The primary responsibility of this method is to allocate
	 Smalltalk Arrays for variables that will be declared as statically-allocated
	 global arrays in the translated code."

	| objectMemoryClass |

	"initialize class variables"
	objectMemory ifNotNil:
		[^self halt].

	objectMemoryClass := self class objectMemoryClass.

	objectMemoryClass initBytesPerWord: objectMemoryClass bytesPerWord.
	objectMemoryClass initialize.
	StackInterpreter initialize.

	super initialize.
	objectMemory := objectMemoryClass simulatorClass new.
	objectMemory coInterpreter: self.

	"Note: we must initialize ConstMinusOne differently for simulation,
		due to the fact that the simulator works only with +ve 32-bit values"
	ConstMinusOne := objectMemory integerObjectOf: -1.

	methodCache := Array new: MethodCacheSize.
	atCache := Array new: AtCacheTotalSize.
	self flushMethodCache.
	self flushAtCache.
	gcSemaphoreIndex := 0.
	externalSemaphoreSignalRequests := externalSemaphoreSignalResponses := #().
	externalPrimitiveTable := CArrayAccessor on: (Array new: MaxExternalPrimitiveTableSize).
	externalPrimitiveTableFirstFreeIndex := 0.
	primitiveTable := self class primitiveTable copy.
	pluginList := #().
	mappedPluginEntries := #().
	desiredNumStackPages := desiredEdenBytes := 0.
	"This is initialized on loading the image, but convenient for testing stack page values..."
	numStackPages := self defaultNumStackPages. 
	startMicroseconds := Time totalSeconds * 1000000.

	"initialize InterpreterSimulator variables used for debugging"
	byteCount := 0.
	sendCount := 0.
	quitBlock := [^ self].
	traceOn := true.
	printSends := printReturns := printFrameAtEachStep := printBytecodeAtEachStep := false.
	myBitBlt := BitBltSimulator new setInterpreter: self.
	transcript := Transcript.
	displayForm := 'Display has not yet been installed' asMorph imageForm.
	suppressHeartbeatFlag := false.
	extSemTabSize := 256.
	disableBooleanCheat := false