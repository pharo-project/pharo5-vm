initialization
initialize
	"Initialize the InterpreterSimulator when running the interpreter inside
	Smalltalk. The primary responsibility of this method is to allocate
	Smalltalk Arrays for variables that will be declared as statically-allocated
	global arrays in the translated code."

	"Note: we must initialize ConstMinusOne differently for simulation,
		due to the fact that the simulator works only with +ve 32-bit values"
	ConstMinusOne := self integerObjectOf: -1.

	methodCache := Array new: MethodCacheSize.
	atCache := Array new: AtCacheTotalSize.
	self flushMethodCache.
	rootTable := Array new: RootTableSize.
	weakRoots := Array new: RootTableSize + RemapBufferSize + 100.
	remapBuffer := Array new: RemapBufferSize.
	gcSemaphoreIndex := 0.
	semaphoresUseBufferA := true.
	semaphoresToSignalA := Array new: SemaphoresToSignalSize.
	semaphoresToSignalB := Array new: SemaphoresToSignalSize.
	externalPrimitiveTable := CArrayAccessor on: (Array new: MaxExternalPrimitiveTableSize).
	primitiveTable := self class primitiveTable.
	pluginList := {'' -> self }.
	mappedPluginEntries := #().

	"initialize InterpreterSimulator variables used for debugging"
	byteCount := 0.
	sendCount := 0.
	quitBlock := [^ self].
	traceOn := true.
	printSends := "printReturns := printBytecodeAtEachStep :=" false.
	myBitBlt := BitBltSimulator new setInterpreter: self.
	headerTypeBytes := CArrayAccessor on: HeaderTypeExtraBytes.
	transcript := Transcript.
	displayForm := 'Display has not yet been installed' asDisplayText form.
	