scheduling
startThreadForThreadInfo: vmThread
	<var: #vmThread type: #'CogVMThread *'>
	<inline: false>
	self assert: vmThread state isNil.
	vmThread state: CTMInitializing.
	"self cCode: ''
		inSmalltalk: [coInterpreter transcript
						cr;
						nextPutAll: 'starting VM thread ';
						print: vmThread index;
						flush.
					 (thisContext home stackOfSize: 10) do:
						[:ctxt|
						coInterpreter transcript cr; print: ctxt; flush]]."
	(self ioNewOS: #startVMThread: Thread: vmThread) = 0 ifTrue:
		[self ioTransferTimeslice.
		^true].
	memoryIsScarce := true.
	"self cCode: [coInterpreter print: 'ERVT failed to spawn so memory is scarce'; cr]"
	^false