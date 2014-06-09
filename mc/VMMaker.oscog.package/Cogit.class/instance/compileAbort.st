compile abstract instructions
compileAbort
	"The start of a CogMethod has a call to a run-time abort routine that either
	 handles an in-line cache failure or a stack overflow.  The routine selects the
	 path depending on ReceiverResultReg; if zero it takes the stack overflow
	 path; if nonzero the in-line cache miss path.  Neither of these paths returns.
	 The abort routine must be called;  In the callee the method is located by
	 adding the relevant offset to the return address of the call."
	stackOverflowCall := self MoveCq: 0 R: ReceiverResultReg.
	backEnd hasLinkRegister
		ifTrue:
			[sendMiss := self PushR: LinkReg.
			 sendMissCall := self Call: (self methodAbortTrampolineFor: methodOrBlockNumArgs)]
		ifFalse:
			[sendMiss :=
			 sendMissCall := self Call: (self methodAbortTrampolineFor: methodOrBlockNumArgs)]