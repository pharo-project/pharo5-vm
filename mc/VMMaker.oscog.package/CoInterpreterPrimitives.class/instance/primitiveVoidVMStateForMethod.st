system control primitives
primitiveVoidVMStateForMethod
	"The receiver is a compiledMethod.  Clear all VM state associated with the method,
	 including any machine code, or machine code pcs in context objects."
	| activeContext methodObj hasCogMethod theFrame thePage |
	<var: #theFrame type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	super primitiveFlushCacheByMethod.
	"One might think (as this author did) that the heap scan is unnecessary if the method does not
	 have a cog method.  But it could be the case that the code zone has recently been reclaimed
	 and so not having a cog method is no indication that it didn't have a cog method some time in
	 the recent past, and that there are indeed still contexts with machine code pcs out there.  The
	 only steps that can be avoided is divorcing frames in the stack zone, and scanning to unlink and
	 free if there isn't a cog method."
	methodObj := self stackTop.
	activeContext := self ensureFrameIsMarried: framePointer SP: stackPointer.
	self ensurePushedInstructionPointer.
	self externalWriteBackHeadFramePointers.
	(hasCogMethod := self methodHasCogMethod: methodObj) ifTrue:
		[self divorceMachineCodeFramesWithMethod: methodObj].
	self ensureAllContextsWithMethodHaveBytecodePCs: methodObj.
	hasCogMethod ifTrue:
		[cogit unlinkSendsTo: methodObj andFreeIf: true].
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
			 self siglong: reenterInterpreter jmp: ReturnToInterpreter]