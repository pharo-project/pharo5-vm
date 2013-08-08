internal interpreter access
setCogVMFlags: flags
	"Set an array of flags indicating various properties of the Cog VM.
	 Bit 2: if set, implies preempting a process does not put it to the back of its run queue"
	flags asUnsignedInteger > 7 ifTrue:
		[^self primitiveFailFor: PrimErrUnsupported].
	preemptionYields := (flags bitAnd: 4) = 0