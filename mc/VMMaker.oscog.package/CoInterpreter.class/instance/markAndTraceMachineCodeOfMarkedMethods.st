object memory support
markAndTraceMachineCodeOfMarkedMethods
	"Deal with a fulGC's effects on machine code.  Mark and
	 trace oops in marked machine code methods.  The stack
	 pages have already been traced so any methods of live
	 stack activations have already been marked and traced."
	<doNotGenerate>
	cogit markAndTraceMachineCodeOfMarkedMethods