enilopmarts
returnToExecutive: inInterpreter postContextSwitch: switchedContext
	"Return to the current frame, either by entering machine code, or longjmp-ing back to the
	 interpreter or simply returning, depending on where we are. To know whether to return or
	 enter machine code we have to know from whence we came.  We could have come from
	 the interpreter, either directly or via a machine code primitive.  We could have come from
	 machine code.  The instructionPointer tells us where from.  If it is above startOfMemory we're
	 in the interpreter.  If it is below, then we are in machine-code unless it is ceReturnToInterpreterPC,
	 in which case we're in a machine-code primitive called from the interpreter."
	<inline: false>
	| cogMethod retValue fullyInInterpreter |
	<var: #cogMethod type: #'CogBlockMethod *'>

	cogit assertCStackWellAligned.
	(self isMachineCodeFrame: framePointer) ifTrue:
		[self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer imbar: false line: #'__LINE__'.
		 "If returning after a context switch then a result may have to be popped from the stack.
		  If the process is suspended at a send then the result of the primitive in which the
		  process was suspended is still on the stack and must be popped into ReceiverResultReg.
		  If not, nothing should be popped and ReceiverResultReg gets the receiver."
		 switchedContext
			ifTrue:
				[cogMethod := self mframeCogMethod: framePointer.
				self assert: (instructionPointer > cogit minCogMethodAddress 
							and: [instructionPointer < cogit maxCogMethodAddress]).
				 (instructionPointer ~= (cogMethod asInteger + cogMethod stackCheckOffset)
				  and: [cogit isSendReturnPC: instructionPointer])
					ifTrue:
						[self assert: (objectMemory addressCouldBeOop: self stackTop).
						 retValue := self popStack]
					ifFalse:
						[retValue := self mframeReceiver: framePointer]]
			ifFalse: [retValue := self mframeReceiver: framePointer].
		 self push: instructionPointer.
		 self push: retValue.
		 cogit ceEnterCogCodePopReceiverReg
		 "NOTREACHED"].
	self setMethod: (self iframeMethod: framePointer).
	fullyInInterpreter := inInterpreter.
	instructionPointer = cogit ceReturnToInterpreterPC ifTrue:
		[instructionPointer := (self iframeSavedIP: framePointer) asUnsignedInteger.
		 fullyInInterpreter := false].
	self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer imbar: true line: #'__LINE__'.
	fullyInInterpreter ifFalse:
		[self siglong: reenterInterpreter jmp: ReturnToInterpreter.
		 "NOTREACHED"].
	^nil