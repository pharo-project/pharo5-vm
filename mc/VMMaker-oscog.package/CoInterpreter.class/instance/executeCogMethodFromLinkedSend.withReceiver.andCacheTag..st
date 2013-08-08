enilopmarts
executeCogMethodFromLinkedSend: cogMethod withReceiver: rcvr andCacheTag: cacheTag
	<api>
	"Execute a CogMethod from a linked send.  The receiver,
	 arguments and return address are on the Smalltalk stack.  First
	 push the entry-point and finally the register argument(s).  Then write
	 back the frame pointers and call the routine that will pop off the register
	 argument(s) and jump to the entry by executing a return instruction.

	 In the simple jit only the receiver gets passed in registers, so only the
	 receiver gets pushed."
	<var: #cogMethod type: #'CogMethod *'>
	cogit assertCStackWellAligned.
	self assert: (self isMachineCodeFrame: framePointer).
	self assertValidExecutionPointe: self stackTop r: framePointer s: stackPointer imbar: false line: #'__LINE__'.
	self push: cogMethod asInteger + cogit entryOffset.
	self
		cppIf: cogit numRegArgs > 0
		ifTrue:
			[cogMethod cmNumArgs <= cogit numRegArgs ifTrue:
				[self assert: cogit numRegArgs <= 2.
				 self push: cacheTag.
				 cogMethod cmNumArgs = 0 ifTrue:
					[cogit ceEnter0ArgsPIC].
				 cogMethod cmNumArgs = 1 ifTrue:
					[cogit ceEnter1ArgsPIC].
				 cogMethod cmNumArgs = 2 ifTrue:
					[cogit ceEnter2ArgsPIC].
				 self error: 'not reached']].
	self
		push: rcvr;
		push: cacheTag.
	cogit ceEnterCogCodePopReceiverAndClassRegs
	"NOTREACHED"