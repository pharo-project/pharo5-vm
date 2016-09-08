initialization
enterSmalltalkExecutiveImplementation
	"Main entry-point into the interpreter at each execution level, where an execution
	 level is either the start of execution or reentry for a callback.  Capture the C stack
	 pointers so that calls from machine-code into the C run-time occur at this level.
	 This is the actual implementation, separated from enterSmalltalkExecutive so the
	 simulator can wrap it in an exception handler and hence simulate the setjmp/longjmp."
	<inline: false>
	cogit assertCStackWellAligned.
	cogit ceCaptureCStackPointers.
	"Setjmp for reentry into interpreter from elsewhere, e.g. machine-code trampolines."
	self sigset: reenterInterpreter jmp: 0.
	(self isMachineCodeFrame: framePointer) ifTrue:
		[self returnToExecutive: false postContextSwitch: true
		 "NOTREACHED"].
	self setMethod: (self iframeMethod: framePointer).
	instructionPointer = cogit ceReturnToInterpreterPC ifTrue:
		[instructionPointer := self iframeSavedIP: framePointer].
	self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer imbar: true line: #'__LINE__'.
	self interpret.
	^0