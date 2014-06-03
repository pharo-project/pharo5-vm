class initialization
initialize
	"CogThreadManager initialize"
	CTMInitializing := 1.
	CTMUnavailable := 2.	"off doing its own thing and not available to run the VM, e.g. calling-out."
	CTMAssignableOrInVM := 3.	"either owning the VM or blocked on its osSemaphore available for VM work"
	CTMWantingOwnership := 4.	"with something specific to do in the VM (e.g. return a result from a call-out, make a call-back)"

	"Define the size of the stack of processes at time of disown/own."
	AWOLProcessesIncrement := 4