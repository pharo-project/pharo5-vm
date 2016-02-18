trampolines
ceNonLocalReturn: returnValue
	<api>
	| closure home unwindContextOrNilOrZero ourContext frameToReturnTo contextToReturnTo theFP callerFP newPage |
	<var: #frameToReturnTo type: #'char *'>
	<var: #theFP type: #'char *'>
	<var: #callerFP type: #'char *'>
	<var: #newPage type: #'StackPage *'>
	<var: #thePage type: #'StackPage *'>

	"self shortPrintFrameAndCallers: framePointer.
	self printOop: returnValue.
	self halt."

	self assert: (self isMachineCodeFrame: framePointer).
	self assert: (self frameIsBlockActivation: framePointer).

	"Since this is a block activation the closure is on the stack above any args and the frame."
	closure := self pushedReceiverOrClosureOfFrame: framePointer.

	home := nil.
	"Walk the closure's lexical chain to find the context or frame to return from (home)."
	[closure ~= objectMemory nilObject] whileTrue:
		[home := objectMemory followField: ClosureOuterContextIndex ofObject: closure.
		 closure := objectMemory followField: ClosureIndex ofObject: home].
	"home is to be returned from provided there is no unwind-protect activation between
	 this frame and home's sender.  Search for an unwind.  findUnwindThroughContext:
	 will answer either the context for an unwind-protect activation or nilObj if the sender
	 cannot be found or 0 if no unwind is found but the sender is.  We must update the
	 current page's headFrame pointers to enable the search to identify widowed contexts
	 correctly."
	self externalWriteBackHeadFramePointers.
	unwindContextOrNilOrZero := self findUnwindThroughContext: home.
	unwindContextOrNilOrZero = objectMemory nilObject ifTrue:
		["error: can't find home on chain; cannot return"
		 ourContext := self ensureFrameIsMarried: framePointer SP: stackPointer.
		 ^self externalCannotReturn: returnValue from: ourContext].
	unwindContextOrNilOrZero ~= 0 ifTrue:
		[^self externalAboutToReturn: returnValue through: unwindContextOrNilOrZero].

	"Now we know home is on the sender chain.
	 We could be returning to either a context or a frame.  Find out which."
	contextToReturnTo := nil.
	(self isMarriedOrWidowedContext: home)
		ifTrue:
			[self assert: (self checkIsStillMarriedContext: home currentFP: framePointer).
			 theFP := self frameOfMarriedContext: home.
			 (self isBaseFrame: theFP)
				ifTrue:
					[contextToReturnTo := self frameCallerContext: theFP]
				ifFalse:
					[frameToReturnTo := self frameCallerFP: theFP]]
		ifFalse:
			[contextToReturnTo := objectMemory fetchPointer: SenderIndex ofObject: home.
			 ((objectMemory isContext: contextToReturnTo)
			  and: [self isMarriedOrWidowedContext: contextToReturnTo]) ifTrue:
				[self assert: (self checkIsStillMarriedContext: contextToReturnTo currentFP: framePointer).
			 	 frameToReturnTo := self frameOfMarriedContext: contextToReturnTo.
				 contextToReturnTo := nil]].

	"If returning to a context we must make a frame for it unless it is dead."
	contextToReturnTo ~= nil ifTrue:
		[frameToReturnTo := self establishFrameForContextToReturnTo: contextToReturnTo.
		 frameToReturnTo == 0 ifTrue:
			["error: home's sender is dead; cannot return"
			 ourContext := self ensureFrameIsMarried: framePointer SP: stackPointer.
			 ^self externalCannotReturn: returnValue from: ourContext]].

	"Now we have a frame to return to.  If it is on a different page we must
	 free intervening pages and nil out intervening contexts.  We must free
	 intervening stack pages because if we leave the pages to be divorced
	 then their contexts will be divorced with intact senders and instruction
	 pointers.  This code is similar to primitiveTerminateTo."
	self assert: stackPages pageListIsWellFormed.
	newPage := stackPages stackPageFor: frameToReturnTo.
	newPage ~~ stackPage ifTrue:
		[| currentCtx thePage nextCntx |
		 currentCtx := self frameCallerContext: stackPage baseFP.
		 self assert: (objectMemory isContext: currentCtx).
		 stackPages freeStackPage: stackPage.
		 [self assert: (objectMemory isContext: currentCtx).
		  (self isMarriedOrWidowedContext: currentCtx)
		   and: [(stackPages stackPageFor: (theFP := self frameOfMarriedContext: currentCtx)) = newPage]] whileFalse:
			[(self isMarriedOrWidowedContext: currentCtx)
				ifTrue:
					[thePage := stackPages stackPageFor: theFP.
					 currentCtx := self frameCallerContext: thePage baseFP.
					 stackPages freeStackPage: thePage]
				ifFalse:
					[nextCntx := objectMemory fetchPointer: SenderIndex ofObject: currentCtx.
					 self markContextAsDead: currentCtx.
					 currentCtx := nextCntx]].
		 self setStackPageAndLimit: newPage.
		 stackPointer := stackPage headSP.
		 framePointer := stackPage headFP].

	"Two cases.  Returning to the top frame or an interior frame.  The
	 top frame has its instruction pointer on top of stack.  An interior
	 frame has its instruction pointer in the caller frame. We need to
	 peel back any frames on the page until we get to the correct frame."
	framePointer = frameToReturnTo
		ifTrue:
			[instructionPointer := self popStack]
		ifFalse:
			[[callerFP := framePointer.
			  framePointer := self frameCallerFP: framePointer.
			  framePointer ~~ frameToReturnTo] whileTrue.
			 instructionPointer := (self frameCallerSavedIP: callerFP) asUnsignedInteger.
			 stackPointer := (self frameCallerSP: callerFP)].
	^self return: returnValue toExecutive: false