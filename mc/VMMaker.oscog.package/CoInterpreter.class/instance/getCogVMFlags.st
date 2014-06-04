internal interpreter access
getCogVMFlags
	"Answer an array of flags indicating various properties of the Cog VM.
	 Bit 0: implies the image's Process class has threadId as its 3rd inst var (zero relative)
	 Bit 1: if set, methods that are interpreted will have the flag bit set in their header
	 Bit 2: if set, implies preempting a process does not put it to the back of its run queue"
	^objectMemory integerObjectOf: (processHasThreadId ifTrue: [1] ifFalse: [0])
						+ (flagInterpretedMethods ifTrue: [2] ifFalse: [0])
						+ (preemptionYields ifTrue: [0] ifFalse: [4])
						+ (noThreadingOfGUIThread ifTrue: [8] ifFalse: [0])