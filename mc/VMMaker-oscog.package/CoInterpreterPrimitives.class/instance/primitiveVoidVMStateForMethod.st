system control primitives
primitiveVoidVMStateForMethod
	"The receiver is a compiledMethod.  Clear all VM state associated with the method,
	 including any machine code, or machine code pcs in context objects."
	<var: #theFrame type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	super primitiveFlushCacheByMethod.
	(self methodHasCogMethod: self stackTop) ifTrue:
		[| activeContext methodObj theFrame thePage |
		methodObj := self stackTop.
		self push: instructionPointer.
		self externalWriteBackHeadFramePointers.
		activeContext := self ensureFrameIsMarried: framePointer SP: stackPointer.
		self divorceMachineCodeFramesWithMethod: methodObj.
		self ensureAllContextsWithMethodHaveBytecodePCs: methodObj.
		cogit unlinkSendsTo: methodObj andFreeIf: true.
		(self isStillMarriedContext: activeContext)
			ifTrue:
				[theFrame := self frameOfMarriedContext: activeContext.
				 thePage := stackPages stackPageFor: theFrame.
				 self assert: thePage headFP = theFrame.
				 self setStackPageAndLimit: thePage.
				 stackPointer := thePage headSP.
				 framePointer := thePage headFP.
				 instructionPointer := self popStack.
				 self assert: methodObj = self stackTop]
			ifFalse:
				[self zeroStackPage. "to avoid assert in marryContextInNewStackPageAndInitializeInterpreterRegisters:"
				 self marryContextInNewStackPageAndInitializeInterpreterRegisters: activeContext.
				 self popStack. "pop bogus machine-code instructionPointer"
				 self assert: methodObj = self stackTop.
				 self siglong: reenterInterpreter jmp: ReturnToInterpreter]]
