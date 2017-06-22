system control primitives
primitiveVoidVMStateForMethod
	"The receiver (or first argument) must be a compiledMethod.  The optional (or second) argument must be a
	 boolean. Clear all VM state associated with the method, including any machine code, or machine code pcs
	 in context objects.  If the optional boolean argument is false do not scan the heap looking for contexts."
	| activeContext methodObj scanHeapForContexts hasCogMethod theFrame thePage |
	<var: #theFrame type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	scanHeapForContexts := true. "See comment ''One might think...'' below"
	"In Smalltalk allow both aMethod voidCogVMState and aMethod voidCogVMStateScanningContextsIf: aBoolean"
	argumentCount = 0
		ifTrue:
			[methodObj := self stackTop]
		ifFalse:
			[methodObj := self stackValue: 1.
			 scanHeapForContexts := self booleanValueOf: self stackTop.
			 self failed ifTrue:
				[^self primitiveFailFor: PrimErrBadArgument]].
	NewspeakVM
		ifFalse:
			[argumentCount > 1 ifTrue:
				[^self primitiveFailFor: PrimErrBadNumArgs]]
		 ifTrue: "In the NewspeakVM we allow VMMirror voidStateFor: method scanningIf: aBoolean as well as the Smalltalk forms."
			[argumentCount >= 2 ifTrue:
				[argumentCount > 2 ifTrue:
					[^self primitiveFailFor: PrimErrBadNumArgs].
				 (objectMemory isOopCompiledMethod: methodObj) ifFalse:
					[^self primitiveFailFor: PrimErrBadArgument]]].
	self flushMethodCacheForMethod: methodObj.
	activeContext := self ensureFrameIsMarried: framePointer SP: stackPointer.
	self ensurePushedInstructionPointer.
	self externalWriteBackHeadFramePointers.
	(hasCogMethod := self methodHasCogMethod: methodObj) ifTrue:
		[self divorceMachineCodeFramesWithMethod: methodObj].
	"One might think (as this author did) that the heap scan is unnecessary if the method does not
	 have a cog method.  But it could be the case that the code zone has recently been reclaimed
	 and so not having a cog method is no indication that it didn't have a cog method some time in
	 the recent past, and that there are indeed still contexts with machine code pcs out there.  The
	 only steps that can be avoided are divorcing frames in the stack zone, and scanning to unlink and
	 free if there isn't a cog method, unless we are told otherwise."
	scanHeapForContexts ifTrue:
		[self ensureAllContextsWithMethodHaveBytecodePCs: methodObj].
	hasCogMethod ifTrue:
		[cogit unlinkSendsTo: methodObj andFreeIf: true].

	"If flushing led to divorce continue in the interpreter."
	(self isStillMarriedContext: activeContext) ifFalse:
		[self zeroStackPage. "to avoid assert in marryContextInNewStackPageAndInitializeInterpreterRegisters:"
		 self marryContextInNewStackPageAndInitializeInterpreterRegisters: activeContext.
		 self popStack. "pop bogus machine-code instructionPointer"
		 self assert: (methodObj = self stackTop or: [argumentCount > 0 and: [methodObj = (self stackValue: 1)]]).
		 self pop: argumentCount.
		 self siglong: reenterInterpreter jmp: ReturnToInterpreter.
		 "NOTREACHED"].
	"If not, work out where we are and continue"
	theFrame := self frameOfMarriedContext: activeContext.
	thePage := stackPages stackPageFor: theFrame.
	self assert: thePage headFP = theFrame.
	self setStackPageAndLimit: thePage.
	self setStackPointersFromPage: thePage.
	instructionPointer := self popStack.
	self assert: (methodObj = self stackTop or: [argumentCount > 0 and: [methodObj = (self stackValue: 1)]]).
	self pop: argumentCount