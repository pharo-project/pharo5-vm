enilopmarts
return: returnValue toExecutive: inInterpreter
	"We have made a context switch, either when interpreting or from machine code.
	 Effectively return to the current frame, either by entering machine code, or
	 longjmp-ing back to the interpreter or simply returning, depending on where we are."

	cogit assertCStackWellAligned.
	(self isMachineCodeFrame: framePointer) ifTrue:
		[self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer imbar: false line: #'__LINE__'.
		 self push: instructionPointer.
		 self push: returnValue.
		 cogit ceEnterCogCodePopReceiverReg
		 "NOTREACHED"].
	self push: returnValue.
	self setMethod: (self iframeMethod: framePointer).
	self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer imbar: true line: #'__LINE__'.
	instructionPointer = cogit ceReturnToInterpreterPC ifTrue:
		[instructionPointer := self iframeSavedIP: framePointer].
	inInterpreter ifTrue:
		[^nil].
	self siglong: reenterInterpreter jmp: ReturnToInterpreter.
	"NOTREACHED"
	^nil