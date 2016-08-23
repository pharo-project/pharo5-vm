rump c stack
rumpCStackSize
	"Allocate a rump C stack for simulation.  This stack is used for C calls, i.e. calls
	 made into the simulated C run-time, typically of routines in CoInterpreter.
	 We also use it to hold in-memory copies of the cStackPointer and cFramePointer
	 variables for simulation speed.  Alas we don't use an in-memory copy of stackLimit,
	 because we need some activity to count in order to implement the ioMSecs
	 routine and the stackLimit check is the ideal one."
	^self threadManager
		ifNil: [RumpCStackSize]
		ifNotNil: [:threadManager| RumpCStackSize * (threadManager maxNumThreads + 1)]