compile abstract instructions
compileAbort
	"The start of a CogMethod has a call to a run-time abort routine that either
	 handles an in-line cache failure or a stack overflow.  The routine selects the
	 path depending on ReceiverResultReg; if zero it takes the stack overflow
	 path; if nonzero the in-line cache miss path.  Neither of these paths returns.
	 The abort routine must be called;  In the callee the method is located by
	 adding the relevant offset to the return address of the call.

	 N.B. This code must match that in compilePICAbort: so that the offset of the
	 return address of the call is the same in methods and closed PICs."
	<returnTypeC: #'AbstractInstruction *'>
	stackOverflowCall := self MoveCq: 0 R: ReceiverResultReg.
	backEnd hasLinkRegister
		ifTrue:
			["If there is a link register it must be saved (pushed onto the stack) before it
			  is smashed by the abort call, and hence needs to be manually handled here"
			 sendMiss := self PushR: LinkReg.
			 ^self Call: (self methodAbortTrampolineFor: methodOrBlockNumArgs)]
		ifFalse:
			[^sendMiss := self Call: (self methodAbortTrampolineFor: methodOrBlockNumArgs)]