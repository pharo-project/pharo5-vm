public api
ensureRunningVMThread: vmIsRelinquishing
	<returnTypeC: #void>
	| vmThread |
	<var: #vmThread type: #'CogVMThread *'>
	(self tryLockVMToIndex: -1) ifFalse:
		["self cCode: [coInterpreter print: 'ERVT failed to lock'; cr]." ^nil].
	(vmThread := self willingVMThread) ifNotNil:
		["If the VM is relinquishing the processor then only schedule a thread if it has work to do."
		 (vmIsRelinquishing
		  and: [vmThread state ~= CTMWantingOwnership]) ifTrue:
			[self releaseVM.
			 ^nil].
		 self setVMOwner: vmThread index.
		 vmOSThread := vmThread osThread.
		 self ioSignalOSSemaphore: (self addressOf: vmThread osSemaphore).
		 self ioTransferTimeslice.
		 "self cCode: [coInterpreter print: 'ERVT signalled '; printNum: vmThread index; cr]."
		 ^nil].

	"If the VM is relinquishing the processor then only schedule a thread if it has work to do."
	vmIsRelinquishing ifTrue:
		[self releaseVM.
		 ^nil].

	"If we have failed to allocate thread storage before there is no point continuing to
	 try to do so.  By this time we should have quite a few threads in the pool."
	(memoryIsScarce
	 or: [(vmThread := self unusedThreadInfo) isNil]) ifTrue:
		[self releaseVM.
		 "self cCode: [coInterpreter print: 'ERVT memory is scarce or no unused thread info or too many threads'; cr]."
		 ^nil].

	self setVMOwner: vmThread index.
	(self startThreadForThreadInfo: vmThread) ifFalse:
		[self releaseVM]