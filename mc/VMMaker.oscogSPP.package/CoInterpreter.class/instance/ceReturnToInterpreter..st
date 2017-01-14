trampolines
ceReturnToInterpreter: anOop
	"Perform a return from a machine code frame to an interpreted frame.
	 The machine code has executed a return instruction when the return address
	 is set to ceReturnToInterpreterPC.  Return the result and switch to the interpreter."
	<api>
	self assert: (objectMemory addressCouldBeOop: anOop).
	self flag: 'are you really sure setStackPageAndLimit: is needed?'.
	"I think you're only doing this for the markStackPageMostRecentlyUsed:
	 and that's probably not needed either"
	self setStackPageAndLimit: stackPage.
	self assert: (self isMachineCodeFrame: framePointer) not.
	self setMethod: (self iframeMethod: framePointer).
	self assertValidExecutionPointe: (self iframeSavedIP: framePointer)
		r: framePointer
		s: stackPointer
		imbar: true
		line: #'__LINE__'.
	instructionPointer := self iframeSavedIP: framePointer.
	self push: anOop.
	self siglong: reenterInterpreter jmp: ReturnToInterpreter.
	"NOTREACHED"
	^nil