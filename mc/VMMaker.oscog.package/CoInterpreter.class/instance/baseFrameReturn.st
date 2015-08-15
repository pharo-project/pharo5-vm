return bytecodes
baseFrameReturn
	"Return from a baseFrame (the bottom frame in a stackPage).  The context to
	 return to (which may be married) is stored in the first word of the stack."
	<inline: true>
	| contextToReturnTo retToContext theFP theSP thePage newPage frameAbove |
	<var: #theFP type: #'char *'>
	<var: #theSP type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #newPage type: #'StackPage *'>
	<var: #frameAbove type: #'char *'>
	contextToReturnTo := self frameCallerContext: localFP.

	"The stack page is effectively free now, so free it.  We must free it to be
	 correct in determining if contextToReturnTo is still married, and in case
	 makeBaseFrameFor: cogs a method, which may cause a code compaction,
	 in which case the frame must be free to avoid the relocation machinery
	 tracing the dead frame.  Since freeing now temporarily violates the page-list
	 ordering invariant, use the assert-free version."
	stackPages freeStackPageNoAssert: stackPage.
	retToContext := objectMemory isContext: contextToReturnTo.
	(retToContext
	 and: [self isStillMarriedContext: contextToReturnTo])
		ifTrue:
			[theFP := self frameOfMarriedContext: contextToReturnTo.
			 thePage := stackPages stackPageFor: theFP.
			 theFP = thePage headFP
				ifTrue:
					[theSP := thePage headSP]
				ifFalse:
					["Returning to some interior frame, presumably because of a sender assignment.
					  Move the frames above to another page (they may be in use, e.g. via coroutining).
					  Make the interior frame the top frame."
					 frameAbove := self findFrameAbove: theFP inPage: thePage.
					 "Since we've just deallocated a page we know that newStackPage won't deallocate an existing one."
					 newPage := stackPages newStackPage.
					 self assert: newPage = stackPage.
					 self moveFramesIn: thePage through: frameAbove toPage: newPage.
					 stackPages markStackPageMostRecentlyUsed: newPage.
					 theFP := thePage headFP.
					 theSP := thePage headSP]]
		ifFalse:
			[(retToContext
			  and: [objectMemory isIntegerObject: (objectMemory fetchPointer: InstructionPointerIndex ofObject: contextToReturnTo)]) ifFalse:
				[| contextToReturnFrom |
				 contextToReturnFrom := stackPages longAt: stackPage baseAddress - objectMemory wordSize.
				 self tearDownAndRebuildFrameForCannotReturnBaseFrameReturnFrom: contextToReturnFrom
					to: contextToReturnTo
					returnValue: localReturnValue.
				^self externalCannotReturn: localReturnValue from: contextToReturnFrom].
			 "We must void the instructionPointer to stop it being updated if makeBaseFrameFor:
			  cogs a method, which may cause a code compaction."
			 instructionPointer := 0.
			 thePage := self makeBaseFrameFor: contextToReturnTo.
			 theFP := thePage headFP.
			 theSP := thePage headSP].
	self setStackPageAndLimit: thePage.
	self assert: (stackPages stackPageFor: theFP) = stackPage.
	localSP := theSP.
	localFP := theFP.
	localIP := self pointerForOop: self internalStackTop.
	localIP asUnsignedInteger < objectMemory startOfMemory ifTrue:
		[localIP asUnsignedInteger ~= cogit ceReturnToInterpreterPC ifTrue:
			["localIP in the cog method zone indicates a return to machine code."
			 ^self returnToMachineCodeFrame].
		 localIP := self pointerForOop: (self iframeSavedIP: localFP)].
	self assert: (self checkIsStillMarriedContext: contextToReturnTo currentFP: localFP).
	self setMethod: (self iframeMethod: localFP).
	self internalStackTopPut: localReturnValue.
	^self fetchNextBytecode