scheduling
startVMThread: vmThread
	"Start a VM thread that will attempt to acquire the VM and proceed
	 to run the VM, taking processes from the runnable process queue."
	<returnTypeC: #void>
	<var: #vmThread type: #'CogVMThread *'>
	self registerVMThread: vmThread.
	vmThread state: CTMAssignableOrInVM.
	coInterpreter threadSchedulingLoop: vmThread