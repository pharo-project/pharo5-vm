process primitive support
checkVMOwnershipFromHeartbeat
	"Check whether the VM is unowned and needs to set a thread running to try and own it.
	 Do not attempt this if the image doesn't have a threadId inst var in Process; the VM
	 can't thread these images."
	<inline: false>
	self sqLowLevelMFence.
	(processHasThreadId
	 and: [cogThreadManager getVMOwner = 0]) ifTrue:
		[cogThreadManager ensureRunningVMThread: relinquishing]