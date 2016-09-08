enilopmarts
executeCogMethod: cogMethod fromUnlinkedSendWithReceiver: rcvr
	"Execute a CogMethod from an unlinked send.  The receiver,
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
	cogit numRegArgs > 0 ifTrue: "dont use and: so as to get Slang to inline cogit numRegArgs > 0"
		[cogMethod cmNumArgs <= cogit numRegArgs ifTrue:
			[self callRegisterArgCogMethod: cogMethod at: cogit noCheckEntryOffset receiver: rcvr]].
	self
		push: cogMethod asInteger + cogit noCheckEntryOffset;
		push: rcvr.
	cogit ceCallCogCodePopReceiverReg
	"NOTREACHED"