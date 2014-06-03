simulation
ioWaitOnOSSemaphore: aSemaphorePtr
	<var: #anOSSemaphore type: #'sqOSSemaphore *'>
	<returnTypeC: #void>
	<doNotGenerate>
	"See platforms/Cross/vm/sq.h for the real definition."
	"Simulate the VM's heartbeat by calling checkVMOwnershipFromHeartbeat
	 if the wait times-out."
	[aSemaphorePtr value waitTimeoutMSecs: 1000] whileTrue:
		[coInterpreter checkVMOwnershipFromHeartbeat]