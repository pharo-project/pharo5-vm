scheduling
unregisterVMThread: vmThread
	"Unegister the current thread in the set of threads."
	<var: #vmThread type: #'CogVMThread *'>
	self assert: (vmThread state ~= nil
				and: [vmThread state ~= CTMInitializing]).
	vmThread
		state: nil;
		osThread: nil.
	self ioSetThreadLocalThreadIndex: 0