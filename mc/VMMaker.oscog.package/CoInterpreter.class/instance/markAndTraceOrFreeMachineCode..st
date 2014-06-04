object memory support
markAndTraceOrFreeMachineCode: fullGCFlag
	"Deal with a fulGC's effects on machine code.  Either mark and trace
	 oops in machine code or free machine-code methods that refer to freed
	 oops.  The stack pages have already been traced so any methods
	 of live stack activations have already been marked and traced."
	cogit markAndTraceObjectsOrFreeMachineCode: fullGCFlag