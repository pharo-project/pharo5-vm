internal interpreter access
getCogVMFlags
	"Answer an array of flags indicating various properties of the Cog VM.
	 These are the same as the image header flags shifted right two bits (excluding float order and full screen flags).
	 Bit 0: implies the image's Process class has threadId as its 3rd inst var (zero relative)
	 Bit 1: if set, methods that are interpreted will have the flag bit set in their header
	 Bit 2: if set, implies preempting a process does not put it to the back of its run queue
	 Bit 3: if set, implies the GUI will run on the first thread and event queues will not be accessed from other threads
	 Bit 4: if set, implies the new finalization scheme where WeakArrays are queued"
	^objectMemory integerObjectOf: (processHasThreadId ifTrue: [1] ifFalse: [0])
									+ (flagInterpretedMethods ifTrue: [2] ifFalse: [0])
									+ (preemptionYields ifTrue: [0] ifFalse: [4])
									+ (noThreadingOfGUIThread ifTrue: [8] ifFalse: [0])
									+ (newFinalization ifTrue: [16] ifFalse: [0])
									+ (imageHeaderFlags >> 2 bitClear: 1 + 2 + 4 + 8 + 16)