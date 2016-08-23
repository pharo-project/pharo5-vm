enilopmarts
executeCogPIC: cogPIC fromLinkedSendWithReceiver: rcvr andCacheTag: cacheTag
	<api>
	"Execute a closed PIC from a linked send, to redispatch based on the rcvr.
	 The receiver, arguments and return address are on the Smalltalk stack.
	 First push the entry-point and finally the register argument(s).  Then write
	 back the frame pointers and call the routine that will pop off the register
	 argument(s) and jump to the entry by executing a return instruction.

	 In the simple jit only the receiver gets passed in registers, so only the
	 receiver gets pushed."
	<var: #cogPIC type: #'CogMethod *'>
	cogit assertCStackWellAligned.
	self assert: (self isMachineCodeFrame: framePointer).
	self assertValidExecutionPointe: self stackTop r: framePointer s: stackPointer imbar: false line: #'__LINE__'.
	self push: cogPIC asInteger + cogit entryOffset.
	cogit numRegArgs > 0 ifTrue:"dont use and: so as to get Slang to inline cogit numRegArgs > 0"
		[cogPIC cmNumArgs <= cogit numRegArgs ifTrue:
			[self push: cacheTag.
			 cogPIC cmNumArgs caseOf: {
				[0]	->	[cogit ceCall0ArgsPIC].
				[1]	->	[cogit ceCall1ArgsPIC].
				[2]	->	[cogit ceCall2ArgsPIC]
			 	}
				otherwise: [].
			 self error: 'not reached']].
	self
		push: rcvr;
		push: cacheTag.
	cogit ceCallCogCodePopReceiverAndClassRegs
	"NOTREACHED"