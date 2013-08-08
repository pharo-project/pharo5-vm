internal interpreter access
getCogVMFlags
	"Answer an array of flags indicating various properties of the Cog VM.
	 Bit 2: if set, implies preempting a process does not put it to the back of its run queue"
	^objectMemory integerObjectOf: (preemptionYields ifTrue: [0] ifFalse: [4])