internal interpreter access
getCogVMFlags
	"Answer an array of flags indicating various properties of the Cog VM.
	 These are the same as the image header flags shifted right two bits (excluding float order and full screen flags).
	 Bit 0: specific to CoInterpreterMT
	 Bit 1: specific to CoInterpreter
	 Bit 2: if set, implies preempting a process does not put it to the back of its run queue
	 Bit 3: specific to CoInterpreterMT
	 Bit 4: if set, implies the new finalization scheme where WeakArrays are queued"
	^objectMemory integerObjectOf: (preemptionYields ifTrue: [0] ifFalse: [4])
									+ (newFinalization ifTrue: [16] ifFalse: [0])
									+ (imageHeaderFlags >> 2 bitClear: 4 + 16)