public api
waitForWork: vmThread
	"Wait for work."
	<var: #vmThread type: #'CogVMThread *'>
	<returnTypeC: #void>
	self assert: vmThread state = CTMAssignableOrInVM.
	self assert: vmOwner ~= vmThread index.
	self ioWaitOnOSSemaphore: (self addressOf: vmThread osSemaphore)