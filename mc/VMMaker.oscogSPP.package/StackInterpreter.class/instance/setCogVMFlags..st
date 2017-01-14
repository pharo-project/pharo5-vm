internal interpreter access
setCogVMFlags: flags
	"Set an array of flags indicating various properties of the Cog VM.
	 Bit 2: if set, implies preempting a process does not put it to the back of its run queue
	 Bit 4: if set, implies the new finalization scheme where WeakArrays are queued"
	flags asUnsignedInteger > 31 ifTrue:
		[^self primitiveFailFor: PrimErrUnsupported].
	preemptionYields := (flags bitAnd: 4) = 0.
	newFinalization := (flags bitAnd: 16) ~= 0