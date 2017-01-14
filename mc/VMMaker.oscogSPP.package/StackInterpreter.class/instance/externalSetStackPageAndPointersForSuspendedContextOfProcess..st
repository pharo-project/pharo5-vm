frame access
externalSetStackPageAndPointersForSuspendedContextOfProcess: aProcess
	"Set stackPage, instructionPointer, framePointer and stackPointer for the suspendedContext of
	 aProcess, marrying the context if necessary, and niling the suspendedContext slot.  This is used
	 on process switch to ensure a context has a stack frame and so can continue execution."
	| newContext theFrame thePage newPage |
	<inline: true>
	<var: #theFrame type: #'char *'>
	<var: #thePage type: #'StackPage *'>
	<var: #newPage type: #'StackPage *'>
	
	newContext := objectMemory fetchPointer: SuspendedContextIndex ofObject: aProcess.
	self assert: (objectMemory isContext: newContext).
	(self isMarriedOrWidowedContext: newContext) ifTrue:
		[self assert: (self checkIsStillMarriedContext: newContext currentFP: framePointer)].
	objectMemory
		storePointerUnchecked: SuspendedContextIndex
		ofObject: aProcess
		withValue: objectMemory nilObject.
	(self isStillMarriedContext: newContext)
		ifTrue:
			[theFrame := self frameOfMarriedContext: newContext.
			 thePage := stackPages stackPageFor: theFrame.
			 theFrame ~= thePage headFP ifTrue:
				["explicit assignment of suspendedContext can cause switch to interior frame."
				 newPage := stackPages newStackPage.
				 self moveFramesIn: thePage
					through: (self findFrameAbove: theFrame inPage: thePage)
					toPage: newPage.
				  stackPages markStackPageLeastMostRecentlyUsed: newPage].
			 self assert: thePage headFP = theFrame]
		ifFalse:
			[thePage := self makeBaseFrameFor: newContext.
			 theFrame := thePage baseFP].
	self setStackPageAndLimit: thePage.
	stackPointer := thePage headSP.
	framePointer := thePage headFP.
	(self isMachineCodeFrame: framePointer) ifFalse:
		[self setMethod: (self iframeMethod: framePointer)].
	instructionPointer := self popStack.
	self assertValidExecutionPointe: instructionPointer r: framePointer s: stackPointer