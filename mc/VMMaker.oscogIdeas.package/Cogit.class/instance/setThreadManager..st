initialization
setThreadManager: aCogThreadManager
	"Initialization of the code generator in the simulator.
	 Used in the separate VM since this VM does not do a second initialization of the interpreter,
	 only a second initialization of the objectMemory."
	<doNotGenerate>
	threadManager := aCogThreadManager "N.B. may be nil"